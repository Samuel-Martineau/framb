use sqlx::postgres::PgPoolOptions;
use std::env;

#[tokio::main]
async fn main() -> Result<(), sqlx::Error> {
    let database_url = env::var("DATABASE_URL").unwrap();

    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await?;

    let row: Vec<(i32,)> = sqlx::query_as("SELECT * FROM everything")
        .fetch_all(&pool)
        .await?;

    println!("Hello, world! {database_url}\nID={:?}", row);

    Ok(())
}
