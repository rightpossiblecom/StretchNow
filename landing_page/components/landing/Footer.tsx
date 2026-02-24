import Link from 'next/link';

export default function Footer() {
    return (
        <footer className="bg-slate-50 dark:bg-[#060913] border-t border-gray-200 dark:border-gray-800 pt-16 pb-8">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
                    <div className="col-span-1 md:col-span-2">
                        <Link href="/" className="flex items-center gap-3 mb-4">
                            <img src="/logo.png" alt="StretchNow Logo" className="w-8 h-8 object-cover rounded-lg shadow-sm" />
                            <span className="font-bold text-xl tracking-tight text-gray-900 dark:text-white">
                                StretchNow
                            </span>
                        </Link>
                        <p className="text-gray-500 dark:text-gray-400 max-w-sm">
                            Gentle stretch reminders during the day. Build a light daily routine, encourage movement, and break long sitting periods without disruptive workflows.
                        </p>
                    </div>

                    <div>
                        <h3 className="font-semibold text-gray-900 dark:text-white mb-4">Legal</h3>
                        <ul className="space-y-3">
                            <li>
                                <Link href="/privacy-policy" className="text-gray-500 hover:text-indigo-600 dark:text-gray-400 dark:hover:text-indigo-400 transition-colors">
                                    Privacy Policy
                                </Link>
                            </li>
                            <li>
                                <Link href="/terms" className="text-gray-500 hover:text-indigo-600 dark:text-gray-400 dark:hover:text-indigo-400 transition-colors">
                                    Terms of Service
                                </Link>
                            </li>
                        </ul>
                    </div>

                    <div>
                        <h3 className="font-semibold text-gray-900 dark:text-white mb-4">Support</h3>
                        <ul className="space-y-3">
                            <li>
                                <Link href="/help" className="text-gray-500 hover:text-indigo-600 dark:text-gray-400 dark:hover:text-indigo-400 transition-colors">
                                    Help Center
                                </Link>
                            </li>
                            <li>
                                <Link href="/contact" className="text-gray-500 hover:text-indigo-600 dark:text-gray-400 dark:hover:text-indigo-400 transition-colors">
                                    Contact Us
                                </Link>
                            </li>
                        </ul>
                    </div>
                </div>

                <div className="border-t border-gray-200 dark:border-gray-800 pt-8 flex flex-col md:flex-row justify-between items-center gap-4">
                    <p className="text-gray-500 dark:text-gray-400 text-sm">
                        © {new Date().getFullYear()} StretchNow. All rights reserved.
                    </p>
                </div>
            </div>
        </footer>
    );
}
