'use client';

import { motion } from 'framer-motion';
import { Bell, ListChecks, Activity, Flame } from 'lucide-react';

const features = [
    {
        name: 'Scheduled Reminders',
        description: 'Set your preferred interval (e.g., every 2 hours) and working hours. The app non-intrusively reminds you when it\'s time to move.',
        icon: Bell,
    },
    {
        name: 'Simple Suggestions',
        description: 'Each reminder comes with a quick, ultra-simple stretch suggestion like a "Neck roll" or "Shoulder stretch".',
        icon: ListChecks,
    },
    {
        name: '1-Minute Quick Mode',
        description: 'No time right now? Hit the 1-Minute Stretch button for a single, immediate movement you can do instantly.',
        icon: Activity,
    },
    {
        name: 'Daily Streaks',
        description: 'Track your daily progress and let a simple visual streak counter motivate you to build a reliable habit.',
        icon: Flame,
    },
];

export default function Features() {
    return (
        <section id="features" className="py-20 bg-gray-50 dark:bg-[#060913]">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center max-w-3xl mx-auto mb-16">
                    <h2 className="text-indigo-600 dark:text-indigo-400 font-semibold tracking-wide uppercase text-sm mb-3">
                        Minimalist Features
                    </h2>
                    <h3 className="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
                        Everything you need. Nothing you don&apos;t.
                    </h3>
                    <p className="text-lg text-gray-600 dark:text-gray-400">
                        We intentionally designed StretchNow to stay out of your way while building your light daily movement routine.
                    </p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-12">
                    {features.map((feature, index) => {
                        const Icon = feature.icon;
                        return (
                            <motion.div
                                key={feature.name}
                                initial={{ opacity: 0, y: 20 }}
                                whileInView={{ opacity: 1, y: 0 }}
                                viewport={{ once: true }}
                                transition={{ duration: 0.5, delay: index * 0.1 }}
                                className="bg-white dark:bg-gray-800 rounded-2xl p-8 shadow-sm border border-gray-100 dark:border-gray-700 hover:shadow-md transition-shadow"
                            >
                                <div className="w-12 h-12 bg-indigo-50 dark:bg-indigo-900/30 rounded-xl flex items-center justify-center mb-6 text-indigo-600 dark:text-indigo-400">
                                    <Icon size={24} />
                                </div>
                                <h4 className="text-xl font-bold text-gray-900 dark:text-white mb-3">
                                    {feature.name}
                                </h4>
                                <p className="text-gray-600 dark:text-gray-400">
                                    {feature.description}
                                </p>
                            </motion.div>
                        );
                    })}
                </div>
            </div>
        </section>
    );
}
