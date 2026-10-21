# Proofread and clean up "02 - Deployment Profile for the Swedish eID Framework.md" for release

## Problem

Version 1.9 of the Deployment Profile is about to be released. The text has accumulated language errors over many versions (grammar, Swedish constructions, typos, inconsistent notation). The document should be cleaned up before release without changing what it requires, and the diff must stay easy to review.

Two other specifications in this repository ("OpenID Connect Profile for Sweden Connect.md" and "OpenID Connect Claims and Scopes Specification.md") were just proofread to the same standard. Use them as the reference for style where this prompt is silent.

The file is edited by hand between sessions, so read the current version before changing anything. The version line and the copyright year are already updated; leave them.

## What must be true when done

### Line breaks

- Existing line breaks are kept. Many paragraphs are hard-wrapped; do not join, reflow or re-wrap them, so that the diff only shows lines where words changed.
- A corrected line may end up shorter or longer than its neighbours; that is fine. Only when a fix spans a line break, move the minimum number of words needed.

### Language

Fix grammar, spelling, punctuation and wording throughout, applying improvements directly rather than flagging them. The standard is plain, correct English. Known issues, all decided:

- "a" before `<saml…>` element names, since "SAML" is read as a word (for example "a `<saml2p:AuthnRequest>` message", not "an"). Same for "a `SingleSignOnService` endpoint".
- Swedish-style forms are replaced: "URL:s", "URI:s", "IdP:s" become "URLs", "URIs", "IdPs". Hyphenated compounds with a code name or acronym become separate words: "`use` attribute", "`isRequired` attribute", "`Message` element", "`Scoping` element", "OK button", "SAD attribute", "XML message", "SSO policy", "MITM or MITB attacks". "MD5- och SHA1-based" becomes "MD5- and SHA1-based".
- References to sections of this document or of referenced documents use "Section" with a capital S when followed by a number, and "chapter" becomes "Section". Running text such as "this section" stays lowercase. Bare cross-references such as "see [2.1.3.2](#…)" become "see Section [2.1.3.2](#…)".
- "MUST not" becomes "MUST NOT", "SHOULD not" becomes "SHOULD NOT". "can not" becomes "cannot".
- Curly or wrong-direction quotes in running text (”man in the middle”) become straight quotes, matching the rest of the document.
- Double spaces inside sentences are removed, as is the stray space in "federation operator .".

Clear errors to fix (non-exhaustive, find the rest):

- "Identify Providers" (Section 2.1.2), "the a `<md:AssertionConsumerService>`" (Section 2.1.2.1), "according the" (Sections 2.1.2.1 and 2.1.3.2), "These certificates merely acts" (Section 2.1.1.2), "requests messages" (Section 2.1.2).
- "Level of Assertion" means "Level of Assurance" (Section 5.4.4). "another Level of Assurance that what" becomes "a Level of Assurance other than the one" (Section 5.4.5). "is presented in along with" (Section 5.4.5).
- "After the Service Provider has encrypted the assertion" means "decrypted" (Section 6.3). "were unsigned authentication requests" means "where" (Section 6.3). "Any verification that fails MUST lead to that the Service Provider rejects" is reworded to "If any verification fails, the Service Provider MUST reject".
- "taken in account" (Section 6.3.2), "makes this an optional step" with plural subject (Section 6.3.2), "match the value the `AssertionConsumerServiceURL`" missing "of" (Section 6.3.2), "the time given it its `IssueInstant`" (Section 6.3.5).
- "the Identity Providers metadata" is possessive (Section 5.4.4). "in order initiate" (Section 5.3.3). "Identity Provider services who prompt" becomes "that prompt" (Section 5.3.3).
- "provide limited services or to use other resources" is made parallel with "denying service" (Section 6.2.1).
- "Typical scenarios where the above requirement apply is" and "prompt the user for its user identity" (Section 7.1.1).
- "the entityID of the Service Requestor" means "Signature Requestor", the term defined in Section 7 (Section 7.1).
- "requirements for crypto algorithm support for being compliant" is reworded (Section 8). "key transport algorithms" is singular, "Services supporting the AES-GCM algorithm SHOULD indicate this in its metadata" takes "their" (Section 8.3/8.4). "the use if SHA-1" and "algoritm" in the Section 8.4 footnote.
- "due to that certificate trust is missing" is reworded (Section 2.1.1.2).
- The change log heading for 1.9 says "Changed between version 1.8 and 1.9"; it becomes "Changes between version 1.8 and 1.9".

### Markup and notation errors to fix

These are typos, not technical changes:

- `<md:IDPSSPDescriptor>` becomes `<md:IDPSSODescriptor>` (Section 2.1.3).
- In Section 5.2, the HTTP-POST sentence refers to `<saml2:AuthnRequest>`; it is `<saml2p:AuthnRequest>`.
- The Section 7.1 example closes `<saml2p:RequesterID>` with `</saml2:RequesterID>`; it must close with `</saml2p:RequesterID>`.
- The `<shibmd:Scope>` examples in Section 2.1.3.1 are missing the closing quote after the namespace URI.
- The Signature Service example in Section 2.1.4 has a stray backtick at the end of its first line.
- The link to Section 2.1.2 in Section 5.1 uses `##service-providers`; it must be `#service-providers`.
- References written `\[[SAML2HokProf](#saml2hokprof)]` or `\[[SAML2Prof](#saml2prof)]` lack the closing backslash; they must match the `\[[X](#x)\]` form used everywhere else.
- The footnote marker in Section 6.2.1 is written `[\*\]`; it must be `\[\*\]` like the other footnotes.
- In Section 6.1, "this profile ([section 6.3](#processing-requirements))" links to Section 5.4's anchor; Section 6.3's anchor is `processing-requirements2`.
- In Section 6.3.4, "see [section 5.4](#message-content)" refers to the requested authentication context, which is Section 5.3 (anchor `message-content`); the number is wrong, not the anchor.
- The \[SC.Registry\] reference title is "Sweden Connect – Registry for Identifiers" (capital I, en dash).

## What must not change

- No normative meaning changes: RFC 2119 keywords keep their level and their place, and no requirement is added, removed, strengthened or weakened.
- The RFC 2119 boilerplate in Section 1.1 is copied text and stays word for word.
- British spellings ("behaviour", "fulfil", "signalling") are left as they are.
- "Sweden Connect Framework" is left as it is; do not rename it.
- Change log entries for versions 1.8 and earlier are historical records and are left untouched.
- Code blocks are left as they are except for the markup errors listed above.
- Headings, anchor names, the table of contents and reference anchors stay as they are.

## If unsure

If a fix might change meaning, or a sentence is ambiguous, leave it and list it in the report instead of guessing. In particular, the Section 6.2 bullet on the `Recipient` attribute refers to Sections 5.3 and 5.4.1; check whether 5.4.1 (Validation of Destination) or 5.4.2 (Validation of Assertion Consumer Addresses) is intended, and report it rather than changing it.

## Verification

- A diff of the file shows only language and notation changes, with no reflowed paragraphs; no RFC 2119 keyword was added, removed or changed in level (compare the counts of each keyword before and after).
- The line count of the file is unchanged, or differs only where a fix required it.
- Every `](#anchor)` link in the file points to an existing `<a name>` anchor.
- The rendered Markdown (IntelliJ preview) shows the same structure as before: same headings, lists, blockquotes and code blocks.

Work autonomously. When done, report back briefly: the categories of changes made, and a list of anything you were unsure of and left untouched.
