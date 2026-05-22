'use client'
import { useState } from 'react'

export default function ContactPage() {
  const [loading, setLoading] = useState(false)

  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    subject: 'General Inquiry',
    message: ''
  })

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    setLoading(true)

    const whatsappMessage = `
*New Contact Message*

👤 Name: ${formData.firstName} ${formData.lastName}
📧 Email: ${formData.email}
📌 Subject: ${formData.subject}

💬 Message:
${formData.message}
    `

    const phoneNumber = '+31687630262'

    const whatsappURL = `https://wa.me/${phoneNumber}?text=${encodeURIComponent(
      whatsappMessage
    )}`

    window.open(whatsappURL, '_blank')

    setLoading(false)

    setFormData({
      firstName: '',
      lastName: '',
      email: '',
      subject: 'General Inquiry',
      message: ''
    })
  }

  return (
    <div className="w-full pb-16 sm:pb-20 md:pb-24">
      <section className="relative h-[35vh] sm:h-[40vh] min-h-[300px] md:min-h-[400px] flex items-center justify-center px-4 sm:px-6 border-b border-white/10">
        <div
          className="absolute inset-0 opacity-20 bg-cover bg-center"
          style={{
            backgroundImage:
              "url('https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=1974&auto=format&fit=crop')"
          }}
        />

        <div className="absolute inset-0 bg-gradient-to-t from-black via-black/80 to-transparent" />

        <div className="relative z-10 text-center max-w-3xl mx-auto mt-8 sm:mt-10 px-4">
          <h1 className="text-3xl sm:text-4xl md:text-5xl lg:text-6xl xl:text-7xl font-black mb-4 sm:mb-6">
            Contact <span className="text-red-500">Us</span>
          </h1>

          <p className="text-base sm:text-lg md:text-xl text-white/70">
            Get in touch instantly through WhatsApp.
          </p>
        </div>
      </section>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 py-12 sm:py-16 md:py-20">
        <div className="grid lg:grid-cols-2 gap-8 sm:gap-12 lg:gap-16">

          {/* LEFT SIDE */}
          <div className="flex flex-col justify-center order-2 lg:order-1">
            <div className="bg-gradient-to-br from-[#111] to-[#1a1a1a] border border-white/10 rounded-[20px] sm:rounded-[30px] md:rounded-[40px] p-6 sm:p-8 md:p-10 relative overflow-hidden">

              <div className="absolute top-0 right-0 w-40 h-40 sm:w-50 sm:h-50 md:w-60 md:h-60 bg-green-500/10 blur-3xl rounded-full" />

              <div className="relative z-10">
                <div className="w-16 h-16 sm:w-20 sm:h-20 rounded-2xl sm:rounded-3xl bg-[#25D366]/20 border border-[#25D366]/30 flex items-center justify-center mb-6 sm:mb-8">
                  <svg
                    className="w-8 h-8 sm:w-10 sm:h-10 text-[#25D366]"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347" />
                  </svg>
                </div>

                <h2 className="text-2xl sm:text-3xl md:text-4xl font-black mb-4 sm:mb-6 leading-tight">
                  Chat Directly on{' '}
                  <span className="text-[#25D366]">WhatsApp</span>
                </h2>

                <p className="text-white/60 text-sm sm:text-base md:text-lg leading-relaxed mb-6 sm:mb-8 md:mb-10">
                  Fill out the contact form and your message will instantly open
                  in WhatsApp. Fast replies, easy communication, and direct support.
                </p>

                <div className="space-y-3 sm:space-y-4">
                  <div className="flex items-center gap-3 sm:gap-4 text-white/70 text-sm sm:text-base">
                    <div className="w-2 h-2 sm:w-3 sm:h-3 rounded-full bg-[#25D366]" />
                    Instant response
                  </div>

                  <div className="flex items-center gap-3 sm:gap-4 text-white/70 text-sm sm:text-base">
                    <div className="w-2 h-2 sm:w-3 sm:h-3 rounded-full bg-[#25D366]" />
                    Available 7 days a week
                  </div>

                  <div className="flex items-center gap-3 sm:gap-4 text-white/70 text-sm sm:text-base">
                    <div className="w-2 h-2 sm:w-3 sm:h-3 rounded-full bg-[#25D366]" />
                    Direct customer support
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* RIGHT SIDE FORM */}
          <div className="bg-white/5 border border-white/10 p-6 sm:p-8 md:p-10 rounded-[20px] sm:rounded-[30px] md:rounded-[40px] backdrop-blur-xl order-1 lg:order-2">
            <h2 className="text-2xl sm:text-3xl font-black mb-6 sm:mb-8">
              Send WhatsApp <span className="text-[#25D366]">Message</span>
            </h2>

            <form onSubmit={handleSubmit} className="flex flex-col gap-4 sm:gap-6">

              <div className="grid sm:grid-cols-2 gap-4 sm:gap-6">
                <div className="flex flex-col gap-2">
                  <label className="text-xs sm:text-sm font-bold text-white/70 uppercase tracking-wide">
                    First Name
                  </label>

                  <input
                    required
                    type="text"
                    value={formData.firstName}
                    onChange={e =>
                      setFormData({
                        ...formData,
                        firstName: e.target.value
                      })
                    }
                    className="bg-black/50 border border-white/10 rounded-xl px-3 sm:px-4 py-2.5 sm:py-3 outline-none focus:border-[#25D366] transition-colors text-sm sm:text-base"

                  />
                </div>

                <div className="flex flex-col gap-2">
                  <label className="text-xs sm:text-sm font-bold text-white/70 uppercase tracking-wide">
                    Last Name
                  </label>

                  <input
                    required
                    type="text"
                    value={formData.lastName}
                    onChange={e =>
                      setFormData({
                        ...formData,
                        lastName: e.target.value
                      })
                    }
                    className="bg-black/50 border border-white/10 rounded-xl px-3 sm:px-4 py-2.5 sm:py-3 outline-none focus:border-[#25D366] transition-colors text-sm sm:text-base"

                  />
                </div>
              </div>

              <div className="flex flex-col gap-2">
                <label className="text-xs sm:text-sm font-bold text-white/70 uppercase tracking-wide">
                  Email
                </label>

                <input
                  required
                  type="email"
                  value={formData.email}
                  onChange={e =>
                    setFormData({
                      ...formData,
                      email: e.target.value
                    })
                  }
                  className="bg-black/50 border border-white/10 rounded-xl px-3 sm:px-4 py-2.5 sm:py-3 outline-none focus:border-[#25D366] transition-colors text-sm sm:text-base"

                />
              </div>

              <div className="flex flex-col gap-2">
                <label className="text-xs sm:text-sm font-bold text-white/70 uppercase tracking-wide">
                  Subject
                </label>

                <select
                  value={formData.subject}
                  onChange={e =>
                    setFormData({
                      ...formData,
                      subject: e.target.value
                    })
                  }
                  className="bg-black/50 border border-white/10 rounded-xl px-3 sm:px-4 py-2.5 sm:py-3 outline-none focus:border-[#25D366] transition-colors cursor-pointer text-white/70 text-sm sm:text-base"
                >
                  <option>General Inquiry</option>
                  <option>Order Support</option>
                  <option>Event Catering</option>
                  <option>Business/Wholesale</option>
                </select>
              </div>

              <div className="flex flex-col gap-2">
                <label className="text-xs sm:text-sm font-bold text-white/70 uppercase tracking-wide">
                  Message
                </label>

                <textarea
                  required
                  rows={5}
                  value={formData.message}
                  onChange={e =>
                    setFormData({
                      ...formData,
                      message: e.target.value
                    })
                  }
                  className="bg-black/50 border border-white/10 rounded-xl px-3 sm:px-4 py-2.5 sm:py-3 outline-none focus:border-[#25D366] transition-colors resize-none text-sm sm:text-base"
                  placeholder="How can we help you today?"
                />
              </div>

              <button
                type="submit"
                disabled={loading}
                className="w-full py-4 sm:py-5 rounded-xl sm:rounded-2xl bg-[#25D366] hover:bg-[#1ebe5d] disabled:opacity-60 transition-all font-black text-base sm:text-lg shadow-[0_0_40px_rgba(37,211,102,0.35)] flex items-center justify-center gap-3"
              >
                <svg
                  className="w-5 h-5 sm:w-6 sm:h-6"
                  fill="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347" />
                </svg>

                {loading ? 'Opening WhatsApp...' : 'Send on WhatsApp'}
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  )
}