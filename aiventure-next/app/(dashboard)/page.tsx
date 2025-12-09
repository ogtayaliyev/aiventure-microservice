import Header from "@/components/layout/Header";
import Footer from "@/components/layout/Footer";

export default function HomePage() {
  return (
    <div className="min-h-screen bg-black text-white">
      <Header />
      <main className="pt-16">
        {/* Votre contenu de page d'accueil ici */}
        <div className="min-h-screen flex items-center justify-center">
          <div className="text-center">
            <h1 className="text-5xl font-bold mb-4">Bienvenue sur AIVenture</h1>
            <p className="text-zinc-400 text-xl">
              Votre plateforme de microservices IA est prête !
            </p>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}
