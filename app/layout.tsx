import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import TopInfoBar from "@/components/TopInfoBar";
import NavbarShell from "@/components/NavbarShell";
import FooterShell from "@/components/FooterShell";
import SupportWidget from "@/components/SupportWidget";
import AgeVerification from "@/components/AgeVerification";
import { Providers } from "./providers";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Friend's Liquor Store - Premium Delivery",
  description: "Amsterdam's most luxurious liquor delivery experience.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="en"
      className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}
      style={{ colorScheme: "dark" }}
    >
      <body className="min-h-full flex flex-col bg-black text-white overflow-x-hidden antialiased selection:bg-red-500 selection:text-white">
        <Providers>
          <AgeVerification />
          
          {/* Global Background Effects - locked strictly over absolute black */}
          <div className="fixed inset-0 bg-black pointer-events-none -z-20" />
          <div className="fixed inset-0 bg-[radial-gradient(circle_at_top,rgba(255,0,0,0.15),transparent_40%)] pointer-events-none -z-10" />
          <div className="fixed inset-0 bg-[radial-gradient(circle_at_bottom,rgba(255,215,0,0.08),transparent_40%)] pointer-events-none -z-10" />

          <TopInfoBar />
          <NavbarShell />
          <main className="flex-1 relative z-10 w-full">{children}</main>
          <FooterShell />
          <SupportWidget />
        </Providers>
      </body>
    </html>
  );
}