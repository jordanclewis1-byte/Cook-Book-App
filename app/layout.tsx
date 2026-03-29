import "./globals.css";
import type { Metadata } from "next";
import Link from "next/link";
import { recipeWritesEnabled } from "@/lib/app-config";

export const metadata: Metadata = {
  title: "Jordan's Cookbook",
  description: "A simple personal cookbook built with Next.js and Supabase."
};

export default function RootLayout({
  children
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>
        <div className="page-shell">
          <header className="site-header">
            <div>
              <p className="eyebrow">Personal Cookbook</p>
              <h1>Jordan&apos;s Cookbook</h1>
            </div>
            <nav className="nav-links">
              <Link href="/">Recipes</Link>
              {recipeWritesEnabled ? <Link href="/add-recipe">Add Recipe</Link> : null}
            </nav>
          </header>
          <main>{children}</main>
        </div>
      </body>
    </html>
  );
}
