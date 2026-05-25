import { SupabaseClient, User } from '@supabase/supabase-js'

/** Ensure public.users row exists (matches auth signup data). */
export async function ensureUserProfile(
  supabase: SupabaseClient,
  user: User,
  fullName?: string | null
) {
  if (!user.email) return { error: new Error('User email is required') }

  const name =
    fullName ||
    (user.user_metadata?.full_name as string | undefined) ||
    null

  // Split full name into first_name and last_name
  const nameParts = name ? name.trim().split(' ') : []
  const firstName = nameParts[0] || ''
  const lastName = nameParts.slice(1).join(' ') || ''

  let error = null
  try {
    const result = await supabase.from('users').upsert(
      {
        id: user.id,
        email: user.email,
        full_name: name || user.email.split('@')[0],
        role: 'customer' as const,
      },
      { onConflict: 'id' }
    )
    error = result.error
  } catch (e) {
    // Table might not exist yet or other error, log but don't crash
    console.error('Error ensuring user profile:', e)
    error = e as Error
  }

  return { error }
}
