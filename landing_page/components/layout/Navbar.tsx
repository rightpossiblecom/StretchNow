import Link from 'next/link';

export default function Navbar() {
    return (
        <nav className="fixed top-0 left-0 right-0 z-50 bg-white/80 dark:bg-[#0a0f1c]/80 backdrop-blur-md border-b border-gray-200 dark:border-gray-800">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex justify-between items-center h-16">
                    <Link href="/" className="flex items-center gap-3">
                        <img src="/logo.png" alt="StretchNow Logo" className="w-9 h-9 object-cover rounded-xl shadow-sm" />
                        <span className="font-bold text-xl tracking-tight text-gray-900 dark:text-white">
                            StretchNow
                        </span>
                    </Link>

                    <div className="hidden md:flex items-center gap-8">
                        <Link href="/#features" className="text-sm font-medium text-gray-600 hover:text-indigo-600 dark:text-gray-300 dark:hover:text-indigo-400 transition-colors">
                            Features
                        </Link>
                        <Link href="/#how-it-works" className="text-sm font-medium text-gray-600 hover:text-indigo-600 dark:text-gray-300 dark:hover:text-indigo-400 transition-colors">
                            How it works
                        </Link>
                        <Link href="/#faq" className="text-sm font-medium text-gray-600 hover:text-indigo-600 dark:text-gray-300 dark:hover:text-indigo-400 transition-colors">
                            FAQ
                        </Link>
                    </div>

                    <div className="flex items-center gap-4">
                        <Link
                            href="#download"
                            className="bg-indigo-600 hover:bg-indigo-700 text-white px-5 py-2.5 rounded-full text-sm font-semibold transition-all hover:shadow-lg hover:-translate-y-0.5"
                        >
                            Get App
                        </Link>
                    </div>
                </div>
            </div>
        </nav>
    );
}
