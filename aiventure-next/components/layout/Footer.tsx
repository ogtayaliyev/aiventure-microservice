import Link from "next/link";

export default function Footer() {
  return (
    <footer className="border-t border-zinc-800 py-12 px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        <div className="grid md:grid-cols-4 gap-8 mb-8">
          <div>
            <div className="flex items-center gap-2 mb-4">
              <div className="w-8 h-8 bg-gradient-to-br from-purple-500 to-pink-500 rounded-lg"></div>
              <span className="text-xl font-bold">AIVenture</span>
            </div>
            <p className="text-zinc-400 text-sm">
              La plateforme IA nouvelle génération
            </p>
          </div>

          <div>
            <h4 className="font-semibold mb-4">Produit</h4>
            <ul className="space-y-2 text-zinc-400 text-sm">
              <li>
                <Link href="/#features" className="hover:text-white transition-colors">
                  Fonctionnalités
                </Link>
              </li>
              <li>
                <Link href="/pricing" className="hover:text-white transition-colors">
                  Tarifs
                </Link>
              </li>
              <li>
                <Link href="/docs" className="hover:text-white transition-colors">
                  Documentation
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h4 className="font-semibold mb-4">Entreprise</h4>
            <ul className="space-y-2 text-zinc-400 text-sm">
              <li>
                <Link href="/about" className="hover:text-white transition-colors">
                  À propos
                </Link>
              </li>
              <li>
                <Link href="/blog" className="hover:text-white transition-colors">
                  Blog
                </Link>
              </li>
              <li>
                <Link href="/careers" className="hover:text-white transition-colors">
                  Carrières
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h4 className="font-semibold mb-4">Légal</h4>
            <ul className="space-y-2 text-zinc-400 text-sm">
              <li>
                <Link href="/privacy" className="hover:text-white transition-colors">
                  Confidentialité
                </Link>
              </li>
              <li>
                <Link href="/terms" className="hover:text-white transition-colors">
                  Conditions
                </Link>
              </li>
              <li>
                <Link href="/security" className="hover:text-white transition-colors">
                  Sécurité
                </Link>
              </li>
            </ul>
          </div>
        </div>

        <div className="border-t border-zinc-800 pt-8 flex flex-col md:flex-row justify-between items-center gap-4">
          <p className="text-zinc-400 text-sm">© 2025 AIVenture. Tous droits réservés.</p>
          <div className="flex gap-6">
            <a href="#" className="text-zinc-400 hover:text-white transition-colors">
              Twitter
            </a>
            <a href="#" className="text-zinc-400 hover:text-white transition-colors">
              GitHub
            </a>
            <a href="#" className="text-zinc-400 hover:text-white transition-colors">
              LinkedIn
            </a>
          </div>
        </div>
      </div>
    </footer>
  );
}
