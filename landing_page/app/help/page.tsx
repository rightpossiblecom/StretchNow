import Navbar from '@/components/layout/Navbar';
import Footer from '@/components/landing/Footer';
import Link from 'next/link';
import { Mail, MessageCircle, FileText } from 'lucide-react';

export default function HelpCenter() {
    return (
        <div className="min-h-screen flex flex-col pt-24 bg-gray-50 dark:bg-[#060913]">
            <Navbar />

            <main className="flex-1 max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-16 w-full">
                <div className="text-center mb-16">
                    <h1 className="text-4xl md:text-5xl font-bold text-gray-900 dark:text-white mb-6">
                        How can we help you?
                    </h1>
                    <p className="text-xl text-gray-600 dark:text-gray-400 max-w-2xl mx-auto">
                        Find answers to common questions or get in touch with our support team.
                    </p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
                    <Link href="/#faq" className="bg-white dark:bg-gray-800 p-8 rounded-2xl shadow-sm hover:shadow-md transition-shadow border border-gray-100 dark:border-gray-700 group">
                        <div className="w-12 h-12 bg-indigo-50 dark:bg-indigo-900/30 rounded-xl flex items-center justify-center mb-6 text-indigo-600 dark:text-indigo-400 group-hover:scale-110 transition-transform">
                            <MessageCircle size={24} />
                        </div>
                        <h3 className="text-xl font-bold text-gray-900 dark:text-white mb-2">FAQs</h3>
                        <p className="text-gray-600 dark:text-gray-400 mb-4">Quick answers to common questions about usage, scheduling, and notifications.</p>
                        <span className="text-indigo-600 dark:text-indigo-400 font-medium my-2 inline-block">Browse FAQ &rarr;</span>
                    </Link>

                    <Link href="/terms" className="bg-white dark:bg-gray-800 p-8 rounded-2xl shadow-sm hover:shadow-md transition-shadow border border-gray-100 dark:border-gray-700 group">
                        <div className="w-12 h-12 bg-indigo-50 dark:bg-indigo-900/30 rounded-xl flex items-center justify-center mb-6 text-indigo-600 dark:text-indigo-400 group-hover:scale-110 transition-transform">
                            <FileText size={24} />
                        </div>
                        <h3 className="text-xl font-bold text-gray-900 dark:text-white mb-2">Documentation</h3>
                        <p className="text-gray-600 dark:text-gray-400 mb-4">Read our terms of service, privacy policy, and detailed app guidelines.</p>
                        <span className="text-indigo-600 dark:text-indigo-400 font-medium my-2 inline-block">View Terms &rarr;</span>
                    </Link>

                    <Link href="/contact" className="bg-white dark:bg-gray-800 p-8 rounded-2xl shadow-sm hover:shadow-md transition-shadow border border-gray-100 dark:border-gray-700 group">
                        <div className="w-12 h-12 bg-indigo-50 dark:bg-indigo-900/30 rounded-xl flex items-center justify-center mb-6 text-indigo-600 dark:text-indigo-400 group-hover:scale-110 transition-transform">
                            <Mail size={24} />
                        </div>
                        <h3 className="text-xl font-bold text-gray-900 dark:text-white mb-2">Email Support</h3>
                        <p className="text-gray-600 dark:text-gray-400 mb-4">Can&apos;t find what you&apos;re looking for? Reach out to us directly via email.</p>
                        <span className="text-indigo-600 dark:text-indigo-400 font-medium my-2 inline-block">Contact Us &rarr;</span>
                    </Link>
                </div>
            </main>

            <Footer />
        </div>
    );
}
