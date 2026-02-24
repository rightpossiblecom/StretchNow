'use client';

import { Clock, Check } from 'lucide-react';
import { motion } from 'framer-motion';

export default function AppScreen() {
    return (
        <div className="w-full max-w-[320px] mx-auto bg-white dark:bg-[#0a0f1c] rounded-[2.5rem] border-[8px] border-gray-900 dark:border-gray-800 shadow-2xl overflow-hidden aspect-[9/19] flex flex-col relative">
            {/* Notch */}
            <div className="absolute top-0 inset-x-0 h-6 bg-gray-900 dark:bg-gray-800 rounded-b-3xl w-1/2 mx-auto z-20" />

            {/* Header */}
            <div className="pt-12 px-6 pb-6 bg-indigo-600 dark:bg-indigo-900 text-white relative z-10">
                <h2 className="text-2xl font-bold mb-1">StretchNow</h2>
                <p className="text-indigo-200 text-sm">Today: 2 of 4 stretches done</p>
            </div>

            {/* Content */}
            <div className="flex-1 px-6 py-8 flex flex-col items-center justify-center relative">
                <motion.div
                    animate={{ scale: [1, 1.05, 1] }}
                    transition={{ duration: 3, repeat: Infinity }}
                    className="w-24 h-24 bg-indigo-50 dark:bg-indigo-900/30 rounded-full flex items-center justify-center mb-8 shadow-inner"
                >
                    <Clock className="w-12 h-12 text-indigo-600 dark:text-indigo-400" />
                </motion.div>

                <h3 className="text-2xl font-bold text-gray-900 dark:text-white mb-2 text-center">
                    Shoulder stretch
                </h3>
                <p className="text-gray-500 dark:text-gray-400 text-center mb-10">
                    Roll your shoulders back and down 5 times.
                </p>

                <div className="w-full space-y-3 mt-auto">
                    <button className="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-4 rounded-2xl flex items-center justify-center gap-2 transition-transform active:scale-95 shadow-lg shadow-indigo-200 dark:shadow-none">
                        <Check size={20} /> Mark as Done
                    </button>
                    <button className="w-full bg-gray-100 hover:bg-gray-200 dark:bg-gray-800 dark:hover:bg-gray-700 text-gray-600 dark:text-gray-300 font-bold py-4 rounded-2xl transition-transform active:scale-95">
                        Skip for now
                    </button>
                </div>
            </div>

            {/* Bottom Bar indicating Streak */}
            <div className="bg-gray-50 dark:bg-gray-900/50 p-4 border-t border-gray-100 dark:border-gray-800 flex justify-between items-center">
                <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Current Streak</span>
                <div className="flex items-center gap-1.5 bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400 px-3 py-1 rounded-full text-sm font-bold">
                    <span>🔥</span> 4 Days
                </div>
            </div>
        </div>
    );
}
