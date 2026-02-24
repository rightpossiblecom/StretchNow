import Navbar from '@/components/layout/Navbar';
import Footer from '@/components/landing/Footer';

export default function TermsOfService() {
    return (
        <div className="min-h-screen flex flex-col pt-24 bg-white dark:bg-[#0a0f1c] text-gray-900 dark:text-gray-100">
            <Navbar />
            <main className="flex-1 max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 w-full">
                <h1 className="text-4xl font-bold mb-4">Terms of Service</h1>
                <p className="text-sm text-gray-500 mb-12">Last Updated: {new Date().toLocaleDateString()}</p>

                <div className="space-y-8 text-lg text-gray-700 dark:text-gray-300">
                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">1. Acceptance of Terms</h2>
                        <p className="mb-4">
                            By downloading, installing, or using the StretchNow app, you agree to comply with and be bound by these Terms of Service. If you do not agree, do not use the application.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">2. Non-Medical Disclaimer (Important)</h2>
                        <p className="mb-4 bg-gray-100 dark:bg-gray-800 p-4 rounded-xl border border-gray-200 dark:border-gray-700">
                            <strong>StretchNow is NOT a medical device, nor does it provide medical advice, physiotherapy, or treatment for any physical conditions or injuries.</strong> The stretch suggestions provided by the app are simple, general movements intended only to encourage breaking long periods of sitting. If you experience pain or discomfort, stop immediately. Consult a physician before starting any new physical routine if you have existing health conditions.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">3. Use License</h2>
                        <p className="mb-4">
                            We grant you a personal, revocable, non-exclusive, non-transferable license to use StretchNow for personal, non-commercial purposes strictly in accordance with these Terms. You may not modify, distribute, or reverse engineer any part of the App.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">4. User Content and Local Storage</h2>
                        <p className="mb-4">
                            StretchNow functions by storing your preferences, streak counts, and completion data locally on your device. You are responsible for the backup of any such data. We are not liable for data loss that occurs if the app is uninstalled or your device is reset or damaged.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">5. Disclaimer of Warranties</h2>
                        <p className="mb-4">
                            The App is provided &quot;as is&quot; and &quot;as available.&quot; We make no warranties, expressed or implied, regarding the application&apos;s uptime, reliability, or suitability for any specific purpose. We do not guarantee that your use of the application will be uninterrupted, error-free, or fully secure.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">6. Limitation of Liability</h2>
                        <p className="mb-4">
                            In no event shall StretchNow, its founders, or affiliates be liable for any personal injury, property damage, or incidental, special, or consequential damages resulting from your use or inability to use the App, even if we have been advised of the possibility of such damages.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">7. Contact Information</h2>
                        <p>
                            If you have any questions regarding these Terms, please contact: <a href="mailto:legal@stretchnow.app" className="text-indigo-600 dark:text-indigo-400 hover:underline">legal@stretchnow.app</a>
                        </p>
                    </section>
                </div>
            </main>
            <Footer />
        </div>
    );
}
