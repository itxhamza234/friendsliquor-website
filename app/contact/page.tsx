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
    <div className="w-full pb-24">
      <section className="relative h-[40vh] min-h-[400px] flex items-center justify-center px-6 border-b border-white/10">
        <div
          className="absolute inset-0 opacity-20 bg-cover bg-center"
          style={{
            backgroundImage:
              "url('https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=1974&auto=format&fit=crop')"
          }}
        />

        <div className="absolute inset-0 bg-gradient-to-t from-black via-black/80 to-transparent" />

        <div className="relative z-10 text-center max-w-3xl mx-auto mt-10">
          <h1 className="text-5xl md:text-7xl font-black mb-6">
            Contact <span className="text-red-500">Us</span>
          </h1>

          <p className="text-xl text-white/70">
            Get in touch instantly through WhatsApp.
          </p>
        </div>
      </section>

      <div className="max-w-7xl mx-auto px-6 py-20">
        <div className="grid lg:grid-cols-2 gap-16">

          {/* LEFT SIDE */}
          <div className="flex flex-col justify-center">
            <div className="bg-gradient-to-br from-[#111] to-[#1a1a1a] border border-white/10 rounded-[40px] p-10 relative overflow-hidden">

              <div className="absolute top-0 right-0 w-60 h-60 bg-green-500/10 blur-3xl rounded-full" />

              <div className="relative z-10">
                <div className="w-20 h-20 rounded-3xl bg-[#25D366]/20 border border-[#25D366]/30 flex items-center justify-center mb-8">
                  <svg
                    className="w-10 h-10 text-[#25D366]"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347" />
                  </svg>
                </div>

                <h2 className="text-4xl font-black mb-6 leading-tight">
                  Chat Directly on{' '}
                  <span className="text-[#25D366]">WhatsApp</span>
                </h2>

                <p className="text-white/60 text-lg leading-relaxed mb-10">
                  Fill out the contact form and your message will instantly open
                  in WhatsApp. Fast replies, easy communication, and direct support.
                </p>

                <div className="space-y-4">
                  <div className="flex items-center gap-4 text-white/70">
                    <div className="w-3 h-3 rounded-full bg-[#25D366]" />
                    Instant response
                  </div>

                  <div className="flex items-center gap-4 text-white/70">
                    <div className="w-3 h-3 rounded-full bg-[#25D366]" />
                    Available 7 days a week
                  </div>

                  <div className="flex items-center gap-4 text-white/70">
                    <div className="w-3 h-3 rounded-full bg-[#25D366]" />
                    Direct customer support
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* RIGHT SIDE FORM */}
          <div className="bg-white/5 border border-white/10 p-10 rounded-[40px] backdrop-blur-xl">
            <h2 className="text-3xl font-black mb-8">
              Send WhatsApp <span className="text-[#25D366]">Message</span>
            </h2>

            <form onSubmit={handleSubmit} className="flex flex-col gap-6">

              <div className="grid sm:grid-cols-2 gap-6">
                <div className="flex flex-col gap-2">
                  <label className="text-sm font-bold text-white/70 uppercase tracking-wide">
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
                    className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-[#25D366] transition-colors"
                    
                  />
                </div>

                <div className="flex flex-col gap-2">
                  <label className="text-sm font-bold text-white/70 uppercase tracking-wide">
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
                    className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-[#25D366] transition-colors"
                    
                  />
                </div>
              </div>

              <div className="flex flex-col gap-2">
                <label className="text-sm font-bold text-white/70 uppercase tracking-wide">
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
                  className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-[#25D366] transition-colors"
                  
                />
              </div>

              <div className="flex flex-col gap-2">
                <label className="text-sm font-bold text-white/70 uppercase tracking-wide">
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
                  className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-[#25D366] transition-colors cursor-pointer text-white/70"
                >
                  <option>General Inquiry</option>
                  <option>Order Support</option>
                  <option>Event Catering</option>
                  <option>Business/Wholesale</option>
                </select>
              </div>

              <div className="flex flex-col gap-2">
                <label className="text-sm font-bold text-white/70 uppercase tracking-wide">
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
                  className="bg-black/50 border border-white/10 rounded-xl px-4 py-3 outline-none focus:border-[#25D366] transition-colors resize-none"
                  placeholder="How can we help you today?"
                />
              </div>

              <button
                type="submit"
                disabled={loading}
                className="w-full py-5 rounded-2xl bg-[#25D366] hover:bg-[#1ebe5d] disabled:opacity-60 transition-all font-black text-lg shadow-[0_0_40px_rgba(37,211,102,0.35)] flex items-center justify-center gap-3"
              >
                <svg
                  className="w-6 h-6"
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