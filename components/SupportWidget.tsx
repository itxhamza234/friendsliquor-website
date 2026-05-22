"use client";

import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';

const faqs = [
  {
    id: 1,
    question: "What are your delivery times?",
    answer: "We offer express same-day delivery within Amsterdam in under 30 minutes. National shipping takes 1-2 business days."
  },
  {
    id: 2,
    question: "What payment methods do you accept?",
    answer: "We accept iDEAL, Visa, Mastercard, American Express, Apple Pay, and PayPal."
  },
  {
    id: 3,
    question: "Can I refund my order?",
    answer: "Unopened bottles can be returned within 14 days of purchase. Special limited edition items are non-refundable."
  },
  {
    id: 4,
    question: "Do you verify age?",
    answer: "Yes, you must be 18+ to order. Our delivery drivers are required to verify your ID upon arrival."
  },
  {
    id: 5,
    question: "Is in-store pickup available?",
    answer: "Absolutely. You can order online and pick up your items at our Amsterdam Centrum or Spui District locations."
  }
];

export default function SupportWidget() {
  const [isOpen, setIsOpen] = useState(false);
  const [activeTab, setActiveTab] = useState<'feedback' | 'faq'>('faq');
  const [expandedFaq, setExpandedFaq] = useState<number | null>(null);
  const [rating, setRating] = useState(0);

  return (
    <div className="fixed bottom-6 right-6 z-50 flex flex-col items-end">
      
      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, y: 20, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 20, scale: 0.95, transition: { duration: 0.2 } }}
            transition={{ type: "spring", stiffness: 300, damping: 25 }}
            className="mb-4 w-full sm:w-[400px] bg-black/90 backdrop-blur-2xl border border-white/10 rounded-[30px] overflow-hidden shadow-[0_10px_50px_rgba(0,0,0,0.8)]"
          >
            {/* Header */}
            <div className="bg-gradient-to-r from-red-950/40 to-black p-6 border-b border-white/10 flex justify-between items-center">
              <div>
                <h3 className="text-xl font-black text-white">Premium <span className="text-red-500">Support</span></h3>
                <p className="text-white/50 text-xs mt-1 tracking-wider uppercase">How can we assist you?</p>
              </div>
              <button 
                onClick={() => setIsOpen(false)}
                className="w-8 h-8 rounded-full bg-white/5 hover:bg-white/10 border border-white/10 flex items-center justify-center text-white/50 hover:text-white transition-colors"
              >
                ✕
              </button>
            </div>

            {/* Tabs */}
            <div className="flex border-b border-white/10">
              <button 
                onClick={() => setActiveTab('faq')}
                className={`flex-1 py-4 text-sm font-bold uppercase tracking-widest transition-colors ${activeTab === 'faq' ? 'text-red-500 border-b-2 border-red-500' : 'text-white/40 hover:text-white/80'}`}
              >
                FAQ
              </button>
              <button 
                onClick={() => setActiveTab('feedback')}
                className={`flex-1 py-4 text-sm font-bold uppercase tracking-widest transition-colors ${activeTab === 'feedback' ? 'text-red-500 border-b-2 border-red-500' : 'text-white/40 hover:text-white/80'}`}
              >
                Feedback
              </button>
            </div>

            {/* Content Area */}
            <div className="p-6 h-[400px] overflow-y-auto scrollbar-thin scrollbar-thumb-red-500/20 scrollbar-track-transparent">
              
              {/* FAQ TAB */}
              {activeTab === 'faq' && (
                <motion.div 
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  className="space-y-4"
                >
                  {faqs.map(faq => (
                    <div key={faq.id} className="border border-white/10 rounded-2xl bg-white/5 overflow-hidden">
                      <button 
                        onClick={() => setExpandedFaq(expandedFaq === faq.id ? null : faq.id)}
                        className="w-full text-left p-4 flex justify-between items-center hover:bg-white/5 transition-colors"
                      >
                        <span className="font-bold text-sm text-white/90">{faq.question}</span>
                        <span className="text-red-500 font-bold ml-4">
                          {expandedFaq === faq.id ? '−' : '+'}
                        </span>
                      </button>
                      <AnimatePresence>
                        {expandedFaq === faq.id && (
                          <motion.div
                            initial={{ height: 0, opacity: 0 }}
                            animate={{ height: 'auto', opacity: 1 }}
                            exit={{ height: 0, opacity: 0 }}
                            className="px-4 pb-4"
                          >
                            <p className="text-white/60 text-sm leading-relaxed border-t border-white/10 pt-4 mt-2">
                              {faq.answer}
                            </p>
                          </motion.div>
                        )}
                      </AnimatePresence>
                    </div>
                  ))}
                  <div className="mt-8 text-center border-t border-white/10 pt-6">
                    <p className="text-white/40 text-xs mb-3 uppercase tracking-wider">Still need help?</p>
                    <a href="https://wa.me/31612345678" target="_blank" rel="noreferrer" className="inline-flex items-center gap-2 px-6 py-3 rounded-full bg-[#25D366]/10 text-[#25D366] border border-[#25D366]/20 hover:bg-[#25D366]/20 transition-colors text-sm font-bold">
                      Chat on WhatsApp
                    </a>
                  </div>
                </motion.div>
              )}

              {/* FEEDBACK TAB */}
              {activeTab === 'feedback' && (
                <motion.div 
                  initial={{ opacity: 0, x: 20 }}
                  animate={{ opacity: 1, x: 0 }}
                >
                  <form className="flex flex-col gap-5" onSubmit={(e) => e.preventDefault()}>
                    <div className="flex flex-col gap-2">
                      <label className="text-xs font-bold text-white/50 uppercase tracking-wide">Experience Rating</label>
                      <div className="flex gap-2">
                        {[1, 2, 3, 4, 5].map((star) => (
                          <button
                            key={star}
                            type="button"
                            onClick={() => setRating(star)}
                            className={`text-2xl transition-all ${rating >= star ? 'text-yellow-400 drop-shadow-[0_0_10px_rgba(255,215,0,0.5)]' : 'text-white/20 hover:text-white/40'}`}
                          >
                            ★
                          </button>
                        ))}
                      </div>
                    </div>

                    <div className="flex flex-col gap-2">
                      <label className="text-xs font-bold text-white/50 uppercase tracking-wide">Name</label>
                      <input type="text" className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 transition-colors text-sm text-white" placeholder="John Doe" />
                    </div>

                    <div className="flex flex-col gap-2">
                      <label className="text-xs font-bold text-white/50 uppercase tracking-wide">Email</label>
                      <input type="email" className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 transition-colors text-sm text-white" placeholder="john@example.com" />
                    </div>

                    <div className="flex flex-col gap-2">
                      <label className="text-xs font-bold text-white/50 uppercase tracking-wide">Feedback</label>
                      <textarea rows={3} className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-red-500 transition-colors resize-none text-sm text-white" placeholder="Tell us about your experience..."></textarea>
                    </div>

                    <button type="submit" className="w-full py-4 rounded-xl bg-red-500 hover:bg-red-600 transition-all font-bold text-sm shadow-[0_0_30px_rgba(255,0,0,0.4)] mt-2">
                      Submit Feedback
                    </button>
                  </form>
                </motion.div>
              )}

            </div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* Floating Button */}
      <motion.button
        onClick={() => setIsOpen(!isOpen)}
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
        className="w-16 h-16 rounded-full bg-red-500 text-white shadow-[0_0_30px_rgba(255,0,0,0.5)] flex items-center justify-center relative group"
      >
        <div className="absolute inset-0 bg-white/20 rounded-full scale-0 group-hover:scale-100 transition-transform duration-300" />
        {isOpen ? (
          <span className="text-2xl relative z-10">✕</span>
        ) : (
          <svg className="w-7 h-7 relative z-10" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z" />
          </svg>
        )}
      </motion.button>

    </div>
  );
}
