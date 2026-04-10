import Link from "next/link";
import { categoryOptions } from "@/lib/recipe-metadata";

export default function HomePage() {
  return (
    <div className="stack">
      <section className="card stack landing-hero">
        <div>
          <h2>What are you cooking?</h2>
          <p className="muted">Search your saved recipes by name, ingredient, or description.</p>
        </div>

        <form action="/search" className="landing-search-form">
          <input
            name="q"
            className="landing-search-input"
            placeholder="Try: salmon, oats, garlic..."
            autoComplete="off"
          />
          <button className="button" type="submit">Search</button>
        </form>
      </section>

      <section className="card stack">
        <p className="muted">Browse by category:</p>
        <div className="button-row">
          <Link className="button button-secondary" href="/search">
            All recipes
          </Link>
          {categoryOptions.map((category) => (
            <Link
              key={category}
              className="button button-secondary"
              href={`/search?category=${encodeURIComponent(category)}`}
            >
              {category}
            </Link>
          ))}
        </div>
      </section>
    </div>
  );
}
