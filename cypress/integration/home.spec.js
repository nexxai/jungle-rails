describe("home page", () => {
  beforeEach(() => {
    cy.visit("http://127.0.0.1:3000");
  });

  it("the home page displays the name of the site", () => {
    cy.get("h1").contains("The Jungle");
  });

  it("can see products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("can see 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});
