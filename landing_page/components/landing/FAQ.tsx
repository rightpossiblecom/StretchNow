'use client';

import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { ChevronDown } from 'lucide-react';

const faqs = [
    {
        question: "Do I need fitness equipment?",
        answer: "No. All stretch suggestions are simple movements that can be done anywhere, designed specifically for office or home desk environments.",
    },
    {
        question: "How often will it remind me?",
        answer: "You are fully in control. You can set the interval to every 2, 3, or customized amount of hours, and also define your working hours so you aren't disturbed at night.",
    },
    {
        question: "Does it track my calories or workouts?",
        answer: "No. StretchNow is not a fitness tracking or medical app. It is a gentle reminder tool intended to simply encourage you to break long periods of sitting.",
    },
    {
        question: "What is the 1-Minute Stretch mode?",
        answer: "If you want a quick movement break outside of your scheduled reminders, tap the 1-Minute feature to get an immediate, fast movement suggestion.",
    },
    {
        question: "Can I connect this to my smartwatch?",
        answer: "Currently, StretchNow is designed as a standalone mobile application focused on simplicity. We do not integrate with external wearables.",
    }
];

export default function FAQ() {
    const [openIndex, setOpenIndex] = useState<number | null>(null);

    return (
        <section id="faq" className="py-24 bg-gray-50 dark:bg-[#060913]">
            <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center mb-16">
                    <h2 className="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
                        Frequently asked questions
                    </h2>
                    <p className="text-lg text-gray-600 dark:text-gray-400">
                        Everything you need to know about the product.
                    </p>
                </div>

                <div className="space-y-4">
                    {faqs.map((faq, index) => (
                        <motion.div
                            key={index}
                            initial={{ opacity: 0, y: 10 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            transition={{ duration: 0.3, delay: index * 0.1 }}
                            className="bg-white dark:bg-gray-800 rounded-2xl border border-gray-100 dark:border-gray-700 overflow-hidden"
                        >
                            <button
                                onClick={() => setOpenIndex(openIndex === index ? null : index)}
                                className="w-full text-left px-6 py-5 flex justify-between items-center focus:outline-none focus-visible:ring-2 focus-visible:ring-indigo-500"
                            >
                                <span className="font-semibold text-gray-900 dark:text-white">
                                    {faq.question}
                                </span>
                                <ChevronDown
                                    className={`w-5 h-5 text-gray-500 dark:text-gray-400 transition-transform duration-300 ${openIndex === index ? 'rotate-180' : ''}`}
                                />
                            </button>

                            <AnimatePresence>
                                {openIndex === index && (
                                    <motion.div
                                        initial={{ height: 0, opacity: 0 }}
                                        animate={{ height: "auto", opacity: 1 }}
                                        exit={{ height: 0, opacity: 0 }}
                                        className="overflow-hidden"
                                    >
                                        <div className="px-6 pb-5 text-gray-600 dark:text-gray-400 border-t border-gray-100 dark:border-gray-700 pt-4">
                                            {faq.answer}
                                        </div>
                                    </motion.div>
                                )}
                            </AnimatePresence>
                        </motion.div>
                    ))}
                </div>
            </div>
        </section>
    );
}
