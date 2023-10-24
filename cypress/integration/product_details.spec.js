describe("products", () => {
  beforeEach(() => {
    cy.visit("http://127.0.0.1:3000");
  });

  it("can browse to a specific product", () => {
    cy.get(".products article").first().click();
  });

  it("displays the name of the product", () => {
    cy.get(".products article").first().click();
    cy.get("h1").contains("Scented Blade");
  });
});
