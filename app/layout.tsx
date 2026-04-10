import "./globals.css";
import type { Metadata, Viewport } from "next";
import Link from "next/link";
import { AuthProvider } from "@/lib/auth-context";
import SiteNav from "@/components/SiteNav";

export const metadata: Metadata = {
  title: "Jordan's Cookbook",
  description: "A personal cookbook for browsing and searching recipes.",
  openGraph: {
    title: "Jordan's Cookbook",
    description: "A personal cookbook for browsing and searching recipes.",
    type: "website"
  },
  twitter: {
    card: "summary",
    title: "Jordan's Cookbook",
    description: "A personal cookbook for browsing and searching recipes."
  }
};

export const viewport: Viewport = {
  themeColor: "#9f4f2b"
};

export default function RootLayout({
  children
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>
        <AuthProvider>
          <div className="page-shell">
            <header className="site-header">
              <div>
                <p className="eyebrow">Personal Cookbook</p>
                <Link href="/">
                  <h1>Jordan&apos;s Cookbook</h1>
                </Link>
              </div>
              <SiteNav />
            </header>
            <main>{children}</main>
          </div>
        </AuthProvider>
      </body>
    </html>
  );
}
