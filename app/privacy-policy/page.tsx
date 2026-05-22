import PolicyLayout from '@/components/PolicyLayout'

export default function PrivacyPolicyPage() {
  return (
    <PolicyLayout
      title="Privacy Policy"
      subtitle="Learn how we collect, use, store, and protect your personal information when using our website and services."
      sections={[
        {
          title: 'Introduction',
          content: (
            <>
              <p>
                Your privacy is important to us. This Privacy Policy explains how we collect,
                use, disclose, and safeguard your information when you visit our website,
                place orders, or interact with our services.
              </p>

              <p>
                By using our website, you agree to the practices described in this policy.
              </p>
            </>
          ),
        },

        {
          title: 'Information We Collect',
          content: (
            <>
              <p>
                We may collect personal and technical information including:
              </p>

              <ul className="list-disc pl-5 space-y-2">
                <li>Full name</li>
                <li>Email address</li>
                <li>Phone number</li>
                <li>Billing and delivery address</li>
                <li>Order history and preferences</li>
                <li>IP address and browser/device information</li>
                <li>Age verification information where required</li>
              </ul>

              <p className="mt-4">
                Payment information is securely processed through trusted payment providers.
                We do not store complete card details on our servers.
              </p>
            </>
          ),
        },

        {
          title: 'How We Use Your Information',
          content: (
            <>
              <p>
                Your information may be used to:
              </p>

              <ul className="list-disc pl-5 space-y-2">
                <li>Process and deliver your orders</li>
                <li>Provide customer support and respond to inquiries</li>
                <li>Verify legal drinking age requirements</li>
                <li>Send order confirmations and delivery updates</li>
                <li>Prevent fraud, abuse, and unauthorized transactions</li>
                <li>Improve our website performance and user experience</li>
                <li>Comply with legal and regulatory obligations</li>
              </ul>
            </>
          ),
        },

        {
          title: 'Payments & Stripe Security',
          content: (
            <>
              <p>
                Payments on our website are securely processed through{' '}
                <a
                  href="https://stripe.com"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-red-400 hover:text-red-300 underline"
                >
                  Stripe
                </a>{' '}
                and other authorized payment providers.
              </p>

              <p>
                Sensitive payment information such as full credit or debit card numbers is
                never stored directly on our servers.
              </p>

              <p>
                Stripe may collect and process payment-related data in accordance with their
                own privacy and security policies.
              </p>
            </>
          ),
        },

        {
          title: 'Cookies & Tracking Technologies',
          content: (
            <>
              <p>
                We may use cookies and similar technologies to improve website functionality,
                analyze traffic, remember preferences, and enhance your browsing experience.
              </p>

              <p>
                You can modify your browser settings to refuse cookies, although some website
                features may not function properly as a result.
              </p>
            </>
          ),
        },

        {
          title: 'Sharing Your Information',
          content: (
            <>
              <p>
                We do not sell or rent your personal information to third parties.
              </p>

              <p>
                Your information may only be shared with trusted service providers where
                necessary to operate our business, including:
              </p>

              <ul className="list-disc pl-5 space-y-2">
                <li>Payment processors</li>
                <li>Delivery and logistics partners</li>
                <li>Website hosting and infrastructure providers</li>
                <li>Fraud prevention and security services</li>
              </ul>

              <p className="mt-4">
                These partners are only permitted to use your information for authorized
                business purposes.
              </p>
            </>
          ),
        },

        {
          title: 'Data Security',
          content: (
            <>
              <p>
                We implement industry-standard security measures to protect your personal
                information from unauthorized access, misuse, disclosure, or destruction.
              </p>

              <p>
                This includes encrypted connections (SSL), secure payment processing, access
                controls, and monitoring systems designed to protect customer data.
              </p>
            </>
          ),
        },

        {
          title: 'Data Retention',
          content: (
            <>
              <p>
                We retain customer and order information only for as long as necessary to
                provide services, comply with legal obligations, resolve disputes, and enforce
                our agreements.
              </p>

              <p>
                Certain transaction records may be retained for accounting, tax, fraud
                prevention, and regulatory compliance purposes.
              </p>
            </>
          ),
        },

        {
          title: 'Your Privacy Rights',
          content: (
            <>
              <p>
                Depending on your location and applicable laws, including GDPR where relevant,
                you may have the right to:
              </p>

              <ul className="list-disc pl-5 space-y-2">
                <li>Access your personal data</li>
                <li>Request correction of inaccurate information</li>
                <li>Request deletion of your personal data</li>
                <li>Withdraw consent for marketing communications</li>
                <li>Request limitation of certain data processing activities</li>
              </ul>

              <p className="mt-4">
                To exercise your rights, please contact us through our{' '}
                <a
                  href="/contact"
                  className="text-red-400 hover:text-red-300 underline"
                >
                  Contact page
                </a>
                .
              </p>
            </>
          ),
        },

        {
          title: 'Third-Party Links',
          content: (
            <>
              <p>
                Our website may contain links to third-party websites or services. We are not
                responsible for the privacy practices, content, or security of external sites.
              </p>

              <p>
                We encourage users to review the privacy policies of any third-party websites
                they visit.
              </p>
            </>
          ),
        },

        {
          title: 'Policy Updates',
          content: (
            <>
              <p>
                We may update this Privacy Policy from time to time to reflect operational,
                legal, or regulatory changes.
              </p>

              <p>
                Any updates will be posted on this page with the revised effective date.
              </p>
            </>
          ),
        },

        {
          title: 'Contact Us',
          content: (
            <>
              <p>
                If you have questions about this Privacy Policy or how your information is
                handled, please contact us through our{' '}
                <a
                  href="/contact"
                  className="text-red-400 hover:text-red-300 underline"
                >
                  Contact page
                </a>
                .
              </p>
            </>
          ),
        },
      ]}
    />
  )
}