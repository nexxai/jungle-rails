describe("cart", () => {
  beforeEach(() => {
    cy.visit("http://127.0.0.1:3000/products/2");
  });

  it("can add an item to the cart", () => {
    cy.get("a[href='/cart']").first().contains("My Cart (0)");
    cy.get(".btn").contains("Add").click();
    cy.get("a[href='/cart']").first().contains("My Cart (1)");
  });
});
