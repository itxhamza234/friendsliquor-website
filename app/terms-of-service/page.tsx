import PolicyLayout from '@/components/PolicyLayout'

export default function TermsOfServicePage() {
  return (
    <PolicyLayout
      title="Terms of Service"
      subtitle="The terms and conditions governing your use of our website, products, and delivery services."
      sections={[
        {
          title: 'Acceptance of Terms',
          content: (
            <>
              <p>
                By accessing or using our website, you agree to comply with and be bound by
                these Terms of Service. If you do not agree with any part of these terms,
                you should not use our services.
              </p>

              <p>
                We reserve the right to update or modify these terms at any time without prior
                notice. Continued use of the website after changes are posted constitutes
                acceptance of those changes.
              </p>
            </>
          ),
        },
        {
          title: 'Eligibility & Legal Drinking Age',
          content: (
            <>
              <p>
                You must be at least 18 years old, or the minimum legal drinking age in your
                jurisdiction, to purchase alcohol from our store.
              </p>

              <p>
                By placing an order, you confirm that you meet all legal age requirements.
                Government-issued identification may be required during delivery for age
                verification purposes.
              </p>

              <p>
                We reserve the right to refuse service, cancel orders, or deny delivery if age
                verification cannot be completed successfully.
              </p>
            </>
          ),
        },
        {
          title: 'Products & Pricing',
          content: (
            <>
              <p>
                All prices displayed on the website are listed in euros (€) and include
                applicable taxes unless otherwise stated.
              </p>

              <p>
                Product availability, vintage years, packaging, images, and descriptions may
                change without notice. While we aim to keep all information accurate, errors
                may occasionally occur.
              </p>

              <p>
                We reserve the right to correct pricing mistakes, limit quantities, refuse
                orders, or cancel transactions affected by stock shortages, technical issues,
                or inaccurate product information.
              </p>
            </>
          ),
        },
        {
          title: 'Orders & Payments',
          content: (
            <>
              <p>
                Orders are subject to acceptance and availability. Once an order is placed,
                you will receive a confirmation email, but this does not guarantee acceptance
                of the order.
              </p>

              <p>
                Payments are securely processed through{' '}
                <a
                  href="https://stripe.com"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-red-400 hover:text-red-300 underline"
                >
                  Stripe
                </a>{' '}
                and other approved payment providers. We do not store your complete payment
                card information on our servers.
              </p>

              <p>
                We reserve the right to cancel suspicious, fraudulent, or unauthorized
                transactions at our sole discretion.
              </p>
            </>
          ),
        },
        {
          title: 'Delivery Policy',
          content: (
            <>
              <p>
                Delivery services are available only within our supported delivery regions.
                Estimated delivery times are provided for convenience and are not guaranteed.
              </p>

              <p>
                Customers are responsible for providing accurate delivery details and ensuring
                that someone of legal drinking age is available to receive the order.
              </p>

              <p>
                Ownership and risk of products pass to the customer upon successful delivery to
                the address provided during checkout.
              </p>
            </>
          ),
        },
        {
          title: 'Returns & Refunds',
          content: (
            <>
              <p>
                Due to the nature of alcoholic beverages and legal restrictions, returns and
                refunds are limited to damaged, defective, incorrect, or materially different
                items.
              </p>

              <p>
                Additional details regarding refunds and return eligibility can be found in our{' '}
                <a
                  href="/refund-policy"
                  className="text-red-400 hover:text-red-300 underline"
                >
                  Refund Policy
                </a>
                .
              </p>
            </>
          ),
        },
        {
          title: 'Acceptable Use',
          content: (
            <>
              <p>
                You agree not to misuse the website, interfere with its operation, attempt
                unauthorized access, or engage in fraudulent or illegal activity.
              </p>

              <p>
                The following activities are strictly prohibited:
              </p>

              <ul className="list-disc pl-5 space-y-2">
                <li>Using false information or payment methods</li>
                <li>Placing fraudulent or abusive orders</li>
                <li>Attempting to disrupt website security or functionality</li>
                <li>Reselling products unlawfully</li>
              </ul>

              <p className="mt-4">
                We reserve the right to suspend or permanently block accounts that violate
                these terms.
              </p>
            </>
          ),
        },
        {
          title: 'Intellectual Property',
          content: (
            <>
              <p>
                All website content including logos, graphics, product images, text, branding,
                and design elements are the property of our store or its licensors and may not
                be copied, reproduced, or distributed without written permission.
              </p>
            </>
          ),
        },
        {
          title: 'Limitation of Liability',
          content: (
            <>
              <p>
                To the maximum extent permitted by law, we shall not be liable for indirect,
                incidental, special, or consequential damages arising from the use of our
                website, products, or delivery services.
              </p>

              <p>
                Our total liability for any claim related to an order shall not exceed the
                amount paid for the specific order in question.
              </p>
            </>
          ),
        },
        {
          title: 'Governing Law',
          content: (
            <>
              <p>
                These Terms of Service are governed by the laws of the Netherlands.
              </p>

              <p>
                Any disputes arising from the use of this website or related transactions
                should first be addressed through our customer support team. Where required,
                disputes shall be subject to the jurisdiction of the competent courts of the
                Netherlands.
              </p>
            </>
          ),
        },
        {
          title: 'Contact Information',
          content: (
            <>
              <p>
                If you have questions regarding these Terms of Service, please contact us
                through our{' '}
                <a href="/contact" className="text-red-400 hover:text-red-300 underline">
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