'use client';

import { motion } from 'framer-motion';

const steps = [
    {
        number: '01',
        title: 'Set Your Schedule',
        description: 'Decide your active hours and how often you want to be softly reminded (e.g. every 2-3 hours).',
    },
    {
        number: '02',
        title: 'Receive a Nudge',
        description: 'A gentle notification appears on your device suggesting a dead-simple stretch to break your sitting period.',
    },
    {
        number: '03',
        title: 'Mark as Done',
        description: 'Perform the movement, tap "Done", and watch your daily completion counter go up. That\'s it.',
    },
];

export default function HowItWorks() {
    return (
        <section id="how-it-works" className="py-24 bg-white dark:bg-[#0a0f1c]">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center mb-16">
                    <h2 className="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
                        How StretchNow works
                    </h2>
                    <p className="text-lg text-gray-600 dark:text-gray-400 max-w-2xl mx-auto">
                        A simple, repeatable loop designed to quietly reinforce healthy behavior.
                    </p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-12 relative">
                    {/* Connecting line for desktop */}
                    <div className="hidden md:block absolute top-[4.5rem] left-[10%] right-[10%] h-0.5 bg-gray-100 dark:bg-gray-800" />

                    {steps.map((step, index) => (
                        <motion.div
                            key={step.number}
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            transition={{ duration: 0.5, delay: index * 0.2 }}
                            className="relative text-center"
                        >
                            <div className="w-20 h-20 mx-auto bg-indigo-600 dark:bg-indigo-500 rounded-2xl flex items-center justify-center mb-6 shadow-xl shadow-indigo-200 dark:shadow-indigo-900/20 relative z-10 text-white font-bold text-2xl rotate-3 hover:rotate-6 transition-transform cursor-default">
                                {step.number}
                            </div>
                            <h3 className="text-xl font-bold text-gray-900 dark:text-white mb-3">
                                {step.title}
                            </h3>
                            <p className="text-gray-600 dark:text-gray-400 leading-relaxed">
                                {step.description}
                            </p>
                        </motion.div>
                    ))}
                </div>
            </div>
        </section>
    );
}
