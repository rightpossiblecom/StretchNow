import Navbar from '@/components/layout/Navbar';
import Footer from '@/components/landing/Footer';
import Hero from '@/components/landing/Hero';
import Features from '@/components/landing/Features';
import HowItWorks from '@/components/landing/HowItWorks';
import FAQ from '@/components/landing/FAQ';

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col selection:bg-indigo-100 selection:text-indigo-900 dark:selection:bg-indigo-900 dark:selection:text-white">
      <Navbar />

      <main className="flex-1">
        <Hero />
        <Features />
        <HowItWorks />
        <FAQ />

        {/* Bottom CTA Section */}
        <section className="py-24 bg-indigo-600 dark:bg-indigo-900 relative overflow-hidden">
          <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-20 mix-blend-overlay"></div>
          <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center relative z-10">
            <h2 className="text-3xl md:text-5xl font-bold text-white mb-6">
              Ready to break up your sitting periods?
            </h2>
            <p className="text-indigo-100 text-lg md:text-xl max-w-2xl mx-auto mb-10">
              Join thousands of users building simple, light daily movement routines with gentle reminders.
            </p>
            <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
              <button className="w-full sm:w-auto bg-white text-indigo-600 hover:bg-gray-50 px-8 py-4 rounded-full text-lg font-bold transition-all hover:shadow-xl hover:-translate-y-1">
                Download StretchNow
              </button>
            </div>
          </div>
        </section>
      </main>

      <Footer />
    </div>
  );
}
