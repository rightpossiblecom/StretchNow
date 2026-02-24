import Navbar from '@/components/layout/Navbar';
import Footer from '@/components/landing/Footer';

export default function PrivacyPolicy() {
    return (
        <div className="min-h-screen flex flex-col pt-24 bg-white dark:bg-[#0a0f1c] text-gray-900 dark:text-gray-100">
            <Navbar />
            <main className="flex-1 max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 w-full">
                <h1 className="text-4xl font-bold mb-4">Privacy Policy</h1>
                <p className="text-sm text-gray-500 mb-12">Last Updated: {new Date().toLocaleDateString()}</p>

                <div className="space-y-8 text-lg text-gray-700 dark:text-gray-300">
                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">1. Introduction</h2>
                        <p className="mb-4">
                            Welcome to StretchNow (&quot;we,&quot; &quot;our,&quot; or &quot;us&quot;). We respect your privacy and are committed to protecting it through our compliance with this policy. This Privacy Policy describes the types of information we may collect from you or that you may provide when you use the StretchNow application (the &quot;App&quot;) and our practices for collecting, using, maintaining, protecting, and disclosing that information.
                        </p>
                        <p>
                            Please note that StretchNow is a tool designed to provide simple stretch reminders. It is not a medical device, nor does it track comprehensive fitness or health data. Our philosophy is privacy-first, tracking as little as possible to deliver core functionality.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">2. Information We Collect</h2>
                        <p className="mb-4">
                            <strong>Local Data Storage:</strong> StretchNow primarily stores data locally on your device. This includes your daily streak data, completed stretch sessions, and your reminder schedule preferences. We do not transmit this personal usage data to external servers.
                        </p>
                        <p className="mb-4">
                            <strong>Automatically Collected Information:</strong> We may collect non-personally identifiable information automatically as you interact with our App, such as device type, app versions, crash logs, and general usage statistics, solely to improve the app&apos;s stability and performance.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">3. How We Use Your Information</h2>
                        <p className="mb-4">
                            We use the information we collect to:
                        </p>
                        <ul className="list-disc pl-6 space-y-2 mb-4 text-gray-600 dark:text-gray-400">
                            <li>Provide, operate, and maintain StretchNow&apos;s reminder functionality.</li>
                            <li>Improve, personalize, and expand the App&apos;s features (e.g., bug fixes and generic UI updates).</li>
                            <li>Analyze how users interact with the application to optimize usability.</li>
                        </ul>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">4. Information Sharing and Disclosure</h2>
                        <p className="mb-4">
                            We do not sell, trade, or rent your personal information to third parties. We may share non-identifiable, aggregated information with analytics providers solely for the purposes described above. If legally required, we may disclose information to comply with valid legal processes.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">5. Data Security</h2>
                        <p className="mb-4">
                            We implement reasonable security measures designed to protect your data. Since most data is stored locally on your device, the security of that data also relies on the physical and software security of your device (e.g., using passcodes or biometric locks).
                        </p>
                    </section>

                    <section>
                        <h2 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">6. Contact Us</h2>
                        <p>
                            If you have any questions or concerns about this Privacy Policy, please contact us at: <a href="mailto:support@stretchnow.app" className="text-indigo-600 dark:text-indigo-400 hover:underline">support@stretchnow.app</a>
                        </p>
                    </section>
                </div>
            </main>
            <Footer />
        </div>
    );
}
