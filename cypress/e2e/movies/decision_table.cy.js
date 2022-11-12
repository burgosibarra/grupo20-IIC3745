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
    };

    const select = {
      branch: "Santiago",
      language: "spanish",
    };

    cy.visit("/");

    Object.keys(params).forEach((i) => {
      cy.get(`#${i}`).type(params[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    cy.get("#language").select("spanish");

    cy.get("input").contains("Buscar").click();

    cy.get(".movie_details:contains(Para todo público)").should(
      "have.length",
      2
    );

    cy.get("#result_0").contains("[ES]");

    cy.get("#result_1").contains("[EN]");

    cy.get(".sala_button:contains(Santiago)").should("have.length", 2);
  });

  it("E2: <18 / Santiago / Inglés", () => {
    const params = {
      date: "2022-12-01",
      age: "16",
    };

    const select = {
      branch: "Santiago",
      language: "english",
    };

    cy.visit("/");

    Object.keys(params).forEach((i) => {
      cy.get(`#${i}`).type(params[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    cy.get("#language").select("english");

    cy.get("input").contains("Buscar").click();

    cy.get(".movie_details:contains(Para todo público)").should(
      "have.length",
      2
    );

    cy.get("#result_0").contains("[EN]");

    cy.get("#result_1").contains("[ES]");

    cy.get(".sala_button:contains(Santiago)").should("have.length", 2);
  });

  it("E3: <18 / Regional / Español", () => {
    const params = {
      date: "2022-12-01",
      age: "16",
    };

    const select = {
      branch: "Regional",
      language: "english",
    };

    cy.visit("/");

    Object.keys(params).forEach((i) => {
      cy.get(`#${i}`).type(params[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    cy.get("#language").select("spanish");

    cy.get("input").contains("Buscar").click();

    cy.get(".movie_details:contains(Para todo público)").should(
      "have.length",
      2
    );

    cy.get("#result_0").contains("[ES]");

    cy.get("#result_1").contains("[EN]");

    cy.get(".sala_button:contains(Regional)").should("have.length", 2);

  });

  it("E4: <18 / Regional / Inglés", () => {
    const params = {
      date: "2022-12-01",
      age: "16",
    };

    const select = {
      branch: "Regional",
      language: "english",
    };

    cy.visit("/");

    Object.keys(params).forEach((i) => {
      cy.get(`#${i}`).type(params[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    cy.get("#language").select("english");

    cy.get("input").contains("Buscar").click();

    cy.get(".movie_details:contains(Para todo público)").should(
      "have.length",
      2
    );


    cy.get("#result_0").contains("[EN]");

    cy.get("#result_1").contains("[ES]");

    cy.get(".sala_button:contains(Regional)").should("have.length", 2);
  });

  it("E5: >=18 / Santiago / Español", () => {
    const params = {
      date: "2022-12-01",
      age: "18",
    };

    const select = {
      branch: "Santiago",
      language: "spanish",
    };

    cy.visit("/");

    Object.keys(params).forEach((i) => {
      cy.get(`#${i}`).type(params[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    cy.get("#language").select("spanish");

    cy.get("input").contains("Buscar").click();

    cy.get(".movie_details:contains(Para todo público)").should(
      "have.length",
      2
    );
    cy.get(".movie_details:contains(Restricción de edad)").should(
      "have.length",
      2
    );

    cy.get("#result_0").contains("[ES]");

    cy.get("#result_1").contains("[ES]");

    cy.get("#result_2").contains("[EN]");

    cy.get("#result_3").contains("[EN]");

    cy.get(".sala_button:contains(Santiago)").should("have.length", 4);
  });

  it("E6: >=18 / Santiago / Inglés", () => {
    const params = {
      date: "2022-12-01",
      age: "18",
    };

    const select = {
      branch: "Santiago",
      language: "english",
    };

    cy.visit("/");

    Object.keys(params).forEach((i) => {
      cy.get(`#${i}`).type(params[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    cy.get("#language").select("english");

    cy.get("input").contains("Buscar").click();

    cy.get(".movie_details:contains(Para todo público)").should(
      "have.length",
      2
    );
    cy.get(".movie_details:contains(Restricción de edad)").should(
      "have.length",
      2
    );

    cy.get("#result_0").contains("[EN]");

    cy.get("#result_1").contains("[EN]");

    cy.get("#result_2").contains("[ES]");

    cy.get("#result_3").contains("[ES]");

    cy.get(".sala_button:contains(Santiago)").should("have.length", 4);
  });

  it("E7: >=18 / Regional / Español", () => {
    const params = {
      date: "2022-12-01",
      age: "18",
    };

    const select = {
      branch: "Regional",
      language: "spanish",
    };

    cy.visit("/");

    Object.keys(params).forEach((i) => {
      cy.get(`#${i}`).type(params[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    cy.get("#language").select("spanish");

    cy.get("input").contains("Buscar").click();

    cy.get(".movie_details:contains(Para todo público)").should(
      "have.length",
      2
    );
    cy.get(".movie_details:contains(Restricción de edad)").should(
      "have.length",
      2
    );

    cy.get("#result_0").contains("[ES]");

    cy.get("#result_1").contains("[ES]");

    cy.get("#result_2").contains("[EN]");

    cy.get("#result_3").contains("[EN]");

    cy.get(".sala_button:contains(Regional)").should("have.length", 4);
  });

  it("E8: >=18 / Regional / Inglés", () => {
    const params = {
      date: "2022-12-01",
      age: "18",
    };

    const select = {
      branch: "Regional",
      language: "english",
    };

    cy.visit("/");

    Object.keys(params).forEach((i) => {
      cy.get(`#${i}`).type(params[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    Object.keys(select).forEach((i) => {
      cy.get(`#${i}`).select(select[i]);
    });

    cy.get("#language").select("english");

    cy.get("input").contains("Buscar").click();

    cy.get(".movie_details:contains(Para todo público)").should(
      "have.length",
      2
    );
    cy.get(".movie_details:contains(Restricción de edad)").should(
      "have.length",
      2
    );

    cy.get("#result_0").contains("[EN]");

    cy.get("#result_1").contains("[EN]");

    cy.get("#result_2").contains("[ES]");

    cy.get("#result_3").contains("[ES]");

    cy.get(".sala_button:contains(Regional)").should("have.length", 4);

  });

  beforeEach(() => {
    cy.app("clean");
    cy.appScenario("seeds");
  });
});

// https://www.shakacode.com/blog/introduction-to-cypress-on-rails/
