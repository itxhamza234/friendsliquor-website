export default function TopInfoBar() {
  const items = [
    { icon: '🚚', text: 'Free delivery above €100' },
    { icon: '🕙', text: 'Lightning fast delivery within 30 minutes!' },
    { icon: '🏪', text: 'Free pickup at our store' },
  ]

  return (
    <div className="bg-gradient-to-r from-red-950 via-black to-red-950 border-b border-white/10 text-white/90 text-xs md:text-sm relative z-[60]">
      <div className="max-w-7xl mx-auto px-4 md:px-6 py-2.5 flex flex-col sm:flex-row items-center justify-center sm:justify-between gap-2 sm:gap-6">
        {items.map((item) => (
          <span
            key={item.text}
            className="flex items-center gap-2 font-medium tracking-wide text-center"
          >
            <span aria-hidden>{item.icon}</span>
            {item.text}
          </span>
        ))}
      </div>
    </div>
  )
}
