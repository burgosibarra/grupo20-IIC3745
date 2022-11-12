const dateString = (date) => {
  const two_digits = (n) => `${n <= 9 ? "0" : ""}${n}`;
  return `${date.getFullYear()}-${two_digits(date.getMonth() + 1)}-${two_digits(
    date.getDate()
  )}`;
};

describe("Tabla de decisión", () => {
  it("E1: <18 / Santiago / Español", () => {
    const params = {
      date: "2022-12-01",
      age: "16",
      branch: "Santiago",
      language: "spanish",
    };

    cy.visit("/");

    Object.keys(params).forEach((i) => {
      cy.get(`#${i}`).type(params[i]);
    });

    cy.get("input").contains("Buscar").click();

    cy.get(".movie_details").contains("Para todo público");

    cy.get(".movie_details").each((m) => {
      console.log(m.id());
    });
  });

  beforeEach(() => {
    cy.app("clean");
    cy.appScenario("seeds");
  });
});

// https://www.shakacode.com/blog/introduction-to-cypress-on-rails/
