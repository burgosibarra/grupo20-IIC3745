describe("Registrar película", () => {
  it("Registrar película correctamente", () => {
    cy.visit("/movie/new");

    cy.get("#title").type("Pride And Prejudice (2005)");
    cy.get("#image").selectFile("public/movies/pride_and_prejudice.jpg");
    cy.get("#min_age").type("10");

    cy.get("input.button").contains("Crear").click();

    cy.get(".notice.is-success");
  });

  it("Registrar película sin nombre", () => {
    cy.visit("/movie/new");

    cy.get("#min_age").type("10");

    cy.get("input.button").contains("Crear").click();

    cy.get(".notice.is-danger");
  });

  beforeEach(() => {
    cy.app("clean");
  });
});
