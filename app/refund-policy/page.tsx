import PolicyLayout from '@/components/PolicyLayout'

export default function RefundPolicyPage() {
  return (
    <PolicyLayout
      title="Refund & Return Policy"
      subtitle="Information about cancellations, returns, refunds, and payment disputes for orders placed through our store."
      sections={[
        {
          title: 'Order Cancellations',
          content: (
            <>
              <p>
                Orders may only be cancelled before they are processed or shipped. Once an
                order has been dispatched, it can no longer be cancelled.
              </p>
              <p>
                To request a cancellation, please contact our support team immediately through
                our Contact page with your order number and purchase details.
              </p>
            </>
          ),
        },
        {
          title: 'Eligibility for Returns',
          content: (
            <>
              <p>
                Due to the nature of alcoholic beverages and age-restricted products, returns
                are only accepted under the following circumstances:
              </p>

              <ul className="list-disc pl-5 space-y-2">
                <li>The wrong product was delivered</li>
                <li>The item arrived damaged or defective</li>
                <li>The product is materially different from its description</li>
              </ul>

              <p className="mt-4">
                To be eligible for review, customers must notify us within 48 hours of delivery
                and provide clear photographs of the product, packaging, and shipping label.
              </p>
            </>
          ),
        },
        {
          title: 'Non-Refundable Products',
          content: (
            <>
              <p>
                In compliance with industry standards and payment processing requirements, we
                cannot offer refunds or returns for:
              </p>

              <ul className="list-disc pl-5 space-y-2">
                <li>Opened or partially consumed bottles</li>
                <li>Products without original seals or packaging</li>
                <li>Items damaged after delivery</li>
                <li>Products purchased during clearance or promotional sales</li>
                <li>Orders refused at delivery due to age verification failure</li>
              </ul>
            </>
          ),
        },
        {
          title: 'Age Verification & Delivery Refusals',
          content: (
            <>
              <p>
                Alcohol sales are restricted to customers who meet the legal drinking age in
                their jurisdiction. Valid government-issued identification may be required upon
                delivery.
              </p>

              <p>
                If delivery is refused because age verification cannot be completed, the order
                may not qualify for a full refund and additional return shipping or restocking
                fees may apply.
              </p>
            </>
          ),
        },
        {
          title: 'Refund Processing',
          content: (
            <>
              <p>
                Approved refunds are processed back to the original payment method used during
                checkout. Refunds typically appear within 5–10 business days depending on your
                bank or card provider.
              </p>

              <p>
                Shipping fees, taxes, and service charges are generally non-refundable unless
                the return is caused by our error or a damaged/incorrect shipment.
              </p>
            </>
          ),
        },
        {
          title: 'Chargebacks & Payment Disputes',
          content: (
            <>
              <p>
                Customers are encouraged to contact us directly before initiating a chargeback
                or payment dispute through their bank or card provider.
              </p>

              <p>
                Fraudulent chargebacks or disputes for successfully delivered orders may result
                in account restrictions and supporting delivery evidence being submitted to the
                payment processor, including Stripe.
              </p>
            </>
          ),
        },
        {
          title: 'Stripe Secure Payments',
          content: (
            <>
              <p>
                All card payments are securely processed through{' '}
                <a
                  href="https://stripe.com"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-red-400 hover:text-red-300 underline"
                >
                  Stripe
                </a>
                . We do not store your full payment card information on our servers.
              </p>

              <p>
                Refunds issued through Stripe are returned only to the original payment method
                and cannot be redirected to another account or card.
              </p>
            </>
          ),
        },
        {
          title: 'Contact Support',
          content: (
            <>
              <p>
                If you need assistance regarding returns, damaged items, or refund requests,
                please contact us through the{' '}
                <a href="/contact" className="text-red-400 hover:text-red-300 underline">
                  Contact page
                </a>{' '}
                with your order number and supporting details.
              </p>

              <p>
                Our support team typically responds within one business day.
              </p>
            </>
          ),
        },
      ]}
    />
  )
}