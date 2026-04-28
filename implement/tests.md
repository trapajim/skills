# Go test examples

Companion to [SKILL.md](./SKILL.md). Prefer **table-driven** tests with **`t.Run(tt.name, …)`** so failures name the case.

---

## Table-driven (pure unit, no DB)

Each row is one input → expected mapping. Same function, many cases.

```go
func TestDiscount_appliesPercent(t *testing.T) {
	tests := []struct {
		name     string
		price    int
		percent  int
		want     int
	}{
		{name: "zero percent", price: 1000, percent: 0, want: 1000},
		{name: "ten percent off", price: 1000, percent: 10, want: 900},
		{name: "rounds down", price: 100, percent: 33, want: 67},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := applyPercentDiscount(tt.price, tt.percent)
			require.Equal(t, tt.want, got)
		})
	}
}
```

Optional **one-off** case that does not fit the table: extra `t.Run("…", …)` after the loop (same file pattern as handler mapping tests).

---

## Table-driven + DB isolation (`WithTx`)

Use a **slice of structs** with `name`, `setup`, and what you assert on. Each `t.Run` wraps work in a transaction so rows do not leak between cases.

```go
func TestListProducts_activeOnly(t *testing.T) {
	client := testutil.TestDB(t)
	defer client.Close()

	tests := []struct {
		name      string
		setup     func(ctx context.Context, c *ent.Client)
		wantCount int
	}{
		{
			name: "returns only active products",
			setup: func(ctx context.Context, c *ent.Client) {
				testutil.CreateProduct(ctx, c, testutil.ProductFactory.MustBuild())
				testutil.CreateProduct(ctx, c,
					testutil.ProductFactory.With(testutil.ProductTraits.Inactive).MustBuild())
			},
			wantCount: 1,
		},
		{
			name:      "empty when none",
			setup:     func(ctx context.Context, c *ent.Client) {},
			wantCount: 0,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			testutil.WithTx(t, client, func(ctx context.Context, tx *ent.Client) {
				tt.setup(ctx, tx)

				status, resp := ExecuteRequest[productResponse](t, tx, RequestOptions{
					Method: http.MethodGet,
					Path:   "/api/v1/products",
				})
				require.Equal(t, http.StatusOK, status)
				require.Len(t, resp.Data, tt.wantCount)
			})
		})
	}
}
```

---

## Assertions: `require` vs `assert`

```go
result, err := svc.Get(ctx, id)
require.NoError(t, err)           // stop if error — avoids panics on nil result
require.NotNil(t, result)
assert.Equal(t, wantName, result.Name) // can continue to more checks
```

Do **not** skip the error path: `result, _ := svc.Get(ctx, id)` hides failures.

---

## Bad patterns (contrast)

**Shared mutable state** — order-dependent and flaky:

```go
var lastID int // BAD: mutated by multiple tests

func TestA(t *testing.T) {
	lastID = create(t)
}
func TestB(t *testing.T) {
	require.Equal(t, 1, lastID) // depends on TestA running first
}
```

**Ignoring errors:**

```go
got, _ := parseInput(s) // BAD
require.Equal(t, want, got)
```

**Coupling to implementation** (private cache / call sequence) instead of public outcome — breaks on refactor without a behavior change.

---

## Naming

- Function: `Test<Thing>_<behavior>` e.g. `TestCreateOrder_rejectsUnknownProduct`.
- Table row: `name: "422 when product_id missing"` — reads in failure output like `--- FAIL: TestCreate/422_when_product_id_missing`.

