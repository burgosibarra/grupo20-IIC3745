const dateString = (date) => {
  const two_digits = (n) => `${n <= 9 ? "0" : ""}${n}`;
  return `${date.getFullYear()}-${two_digits(date.getMonth() + 1)}-${two_digits(
    date.getDate()
  )}`;
};

describe("Asignar película", () => {
  it("Asignar película a sala correctamente", () => {
    const date = new Date();

    date.setDate(date.getDate() + 1);

    const start_date = dateString(date);

    date.setDate(date.getDate() + 7);

    const end_date = dateString(date);
    cy.visit("/movie/new");

    cy.get("#title").type("Pride And Prejudice (2005)");
    cy.get("#image").selectFile("public/movies/pride_and_prejudice.jpg");

    cy.get("input.button").contains("Crear").click();

    cy.get("#movie_time_movie_id").select("1");

    cy.get("#movie_time_time").select("MATINÉ");

    cy.get("#movie_time_date_start").type(start_date);

    cy.get("#movie_time_date_end").type(end_date);

    cy.get("#movie_time_room").select("1");

    cy.get("input.button").contains("Asignar").click();

    cy.get(".notice.is-success");
  });

  it("Asignar películas en horarios diferentes", () => {
    const date = new Date();

    date.setDate(date.getDate() + 1);

    const start_date = dateString(date);

    date.setDate(date.getDate() + 7);

    const end_date = dateString(date);
    cy.visit("/movie/new");

    cy.get("#title").type("Pride And Prejudice (2005)");
    cy.get("#image").selectFile("public/movies/pride_and_prejudice.jpg");
    cy.get("input.button").contains("Crear").click();
    cy.get("#movie_time_movie_id").select("1");
    cy.get("#movie_time_time").select("MATINÉ");
    cy.get("#movie_time_date_start").type(start_date);
    cy.get("#movie_time_date_end").type(end_date);
    cy.get("#movie_time_room").select("1");
    cy.get("input.button").contains("Asignar").click();

    cy.get("#title").type("Mi Vecino Totoro (1988)");
    cy.get("#image").selectFile("public/movies/mi_vecino_totoro.jpg");
    cy.get("input.button").contains("Crear").click();
    cy.get("#movie_time_movie_id").select("2");
    cy.get("#movie_time_time").select("TANDA");
    cy.get("#movie_time_date_start").type(start_date);
    cy.get("#movie_time_date_end").type(end_date);
    cy.get("#movie_time_room").select("1");
    cy.get("input.button").contains("Asignar").click();
    cy.get(".notice.is-success");
  });

  it("Asignar películas en horarios iguales", () => {
    const date = new Date();

    date.setDate(date.getDate() + 1);

    const start_date = dateString(date);

    date.setDate(date.getDate() + 7);

    const end_date = dateString(date);
    cy.visit("/movie/new");

    cy.get("#title").type("Pride And Prejudice (2005)");
    cy.get("#image").selectFile("public/movies/pride_and_prejudice.jpg");
    cy.get("input.button").contains("Crear").click();
    cy.get("#movie_time_movie_id").select("1");
    cy.get("#movie_time_time").select("MATINÉ");
    cy.get("#movie_time_date_start").type(start_date);
    cy.get("#movie_time_date_end").type(end_date);
    cy.get("#movie_time_room").select("1");
    cy.get("input.button").contains("Asignar").click();

    cy.get("#title").type("Mi Vecino Totoro (1988)");
    cy.get("#image").selectFile("public/movies/mi_vecino_totoro.jpg");
    cy.get("input.button").contains("Crear").click();
    cy.get("#movie_time_movie_id").select("2");
    cy.get("#movie_time_time").select("MATINÉ");
    cy.get("#movie_time_date_start").type(start_date);
    cy.get("#movie_time_date_end").type(end_date);
    cy.get("#movie_time_room").select("1");
    cy.get("input.button").contains("Asignar").click();
    cy.get(".notice.is-danger");
  });
});
