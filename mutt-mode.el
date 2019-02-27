;;; mutt-mode.el --- major mode for editing mutt configuration -*- lexical-binding: t; -*-

;; Copyright (c) 2019 Felix Weilbach <felix.weilbach@t-online.de>

;; Author: Felix Weilbach <felix.weilbach@t-online.de>
;; URL: https://gitlab.com/flexw/mutt-mode
;; Keywords: languages
;; Version: 0.1
;; Package-Requires: ((emacs "24"))

;; This file is not part of GNU Emacs.

;;; License:

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Major mode for mutt configuration files.  Highlights the syntax of mutt configuration files.

;;; Code:
(defvar mutt-mode-syntax-table
  (let ((syn-table (make-syntax-table)))
    (modify-syntax-entry ?# "<" syn-table)
    (modify-syntax-entry ?\n ">" syn-table)
    (modify-syntax-entry ?- "w" syn-table)
    (modify-syntax-entry ?_ "w" syn-table)
    (modify-syntax-entry ?' "\"" syn-table)
    (modify-syntax-entry ?< "w" syn-table)
    (modify-syntax-entry ?> "w" syn-table)
    syn-table)
  "The syntax table to use for Mutt mode.
This is buffer-local in every such buffer.")

(defvar mutt-font-lock-keywords
      (let* (
	     (x-keywords '( "account-hook"
			    "alias"
			    "unalias"
			    "alternates"
			    "unalternates"
			    "alternative_order"
			    "unalternative_order"
			    "attachments"
			    "unattachments"
			    "auto_view"
			    "unauto_view"
			    "bind"
			    "charset-hook"
			    "iconv-hook"
			    "color"
			    "uncolor"
			    "crypt-hook"
			    "echo"
			    "exec"
			    "fcc-hook"
			    "fcc-save-hook"
			    "folder-hook"
			    "group"
			    "ungroup"
			    "hdr_order"
			    "unhdr_order"
			    "ignore"
			    "unignore"
			    "index-format-hook"
			    "lists"
			    "unlists"
			    "macro"
			    "mailboxes"
			    "unmailboxes"
			    "mailto_allow"
			    "unmailto_allow"
			    "mbox-hook"
			    "message-hook"
			    "mime_lookup"
			    "unmime_lookup"
			    "mono"
			    "unmono"
			    "my_hdr"
			    "unmy_hdr"
			    "push"
			    "save-hook"
			    "score"
			    "unscore"
			    "reply-hook"
			    "send-hook"
			    "send2-hook"
			    "set"
			    "toggle"
			    "unset"
			    "reset"
			    "setenv"
			    "unsetenv"
			    "sidebar_whitelist"
			    "unsidebar_whitelist"
			    "source"
			    "spam"
			    "nospam"
			    "subjectrx"
			    "unsubjectrx"
			    "subscribe"
			    "unsubscribe"
			    "unhook"))
	     (x-types '("yes"
			"no"
			"ask-yes"
			"ask-no"
			"Maildir"
			"MH"
			"MMDF"
			"mbox"))
	     (x-constants '("attachment"
			    "bold"
			    "error"
			    "hdrdefault"
			    "indicator"
			    "markers"
			    "message"
			    "normal"
			    "prompt"
			    "search"
			    "signature"
			    "status"
			    "tilde"
			    "tree"
			    "underline"
			    "header"
			    "index_author"
			    "index_collapsed"
			    "index_date"
			    "index_flags"
			    "index_label"
			    "index_number"
			    "index_size"
			    "index_subject"
			    "index_tag"
			    "index_tags"
			    "indicator"
			    "progress"
			    "security_encrypt"
			    "security_sign"
			    "security_both"
			    "security_none"
			    "white"
			    "black"
			    "green"
			    "magenta"
			    "blue"
			    "cyan"
			    "yellow"
			    "red"
			    "default"
			    "generic"
			    "body"
			   "alias"
			   "attach"
			   "browser"
			   "compose"
			   "editor"
			   "index"
			   "compose"
			   "pager"
			   "pgp"
			   "smime"
			   "postpone"
			   "query"
			   "mix"
			   "abort_noattach"
			   "abort_noattach_regexp"
			   "abort_nosubject"
			   "abort_unmodified"
			   "alias_file"
			   "alias_format"
			   "allow_8bit"
			   "allow_ansi"
			   "arrow_cursor"
			   "ascii_chars"
			   "askbcc"
			   "askcc"
			   "assumed_charset"
			   "attach_charset"
			   "attach_format"
			   "attach_sep"
			   "attach_split"
			   "attribution"
			   "attribution_locale"
			   "auto_tag"
			   "autoedit"
			   "beep"
			   "beep_new"
			   "bounce"
			   "bounce_deliverd"
			   "braille_friendly"
			   "browser_abbreviate_mailboxes"
			   "certificate_file"
			   "change_folder_next"
			   "charset"
			   "check_mbox_size"
			   "check_new"
			   "collapse_unread"
			   "compose_format"
			   "config_charset"
			   "confirmappend"
			   "confirmcreate"
			   "connect_timeout"
			   "content_type"
			   "copy"
			   "crypt_autoencrypt"
			   "crypt_autopgp"
			   "crypt_autosign"
			   "crypt_autosmime"
			   "crypt_confirmhook"
			   "crypt_opportunistic_encrypt"
			   "crypt_replyencrypt"
			   "crypt_replysign"
			   "crypt_replysignencrypted"
			   "crypt_timestamp"
			   "crypt_use_gpgme"
			   "crypt_use_pka"
			   "crypt_verify_sig"
			   "date_format"
			   "default_hook"
			   "delete"
			   "delete_untag"
			   "digest_collapse"
			   "display_filter"
			   "dotlock_program"
			   "dsn_notify"
			   "dsn_return"
			   "duplicate_threads"
			   "edit_headers"
			   "editor"
			   "encode_form"
			   "entropy_file"
			   "envelope_from_address"
			   "error_history"
			   "escape"
			   "fast_reply"
			   "fcc_attach"
			   "fcc_clear"
			   "flag_safe"
			   "folder"
			   "folder_format"
			   "followup_to"
			   "force_name"
			   "forward_attribution_intro"
			   "forward_attribution_trailer"
			   "forward_decode"
			   "forward_decrypt"
			   "forward_edit"
			   "forward_format"
			   "forward_quote"
			   "from"
			   "gecos_mask"
			   "hdrs"
			   "header"
			   "header_cache"
			   "header_cache_compress"
			   "header_cache_pagesize"
			   "header_color_partial"
			   "help"
			   "hidden_host"
			   "hide_limited"
			   "hide_missing"
			   "hide_thread_subject"
			   "hide_top_limited"
			   "hide_top_missing"
			   "history"
			   "history_file"
			   "history_remove_dups"
			   "honor_disposition"
			   "honor_follow_up"
			   "hostname"
			   "idn_decode"
			   "idn_encode"
			   "ignore_linear_white_space"
			   "ignore_list_reply_to"
			   "imap_authenticators"
			   "imap_check_subscribed"
			   "imap_condstore"
			   "imap_delim_chars"
			   "imap_headers"
			   "imap_idle"
			   "imap_keepalive"
			   "imap_list_subscribed"
			   "imap_login"
			   "imap_oauth_refresh_command"
			   "imap_pass"
			   "imap_passive"
			   "imap_peek"
			   "imap_pipeline_depth"
			   "imap_poll_timeout"
			   "imap_qresync"
			   "imap_servernoise"
			   "imap_user"
			   "implicit_autoview"
			   "include"
			   "include_onlyfirst"
			   "indent_string"
			   "index_format"
			   "ispell"
			   "keep_flagged"
			   "mail_check"
			   "mail_check_recent"
			   "mail_check_stats"
			   "mail_check_stats_interval"
			   "mailcap_path"
			   "mailcap_sanitize"
			   "maildir_header_cache_verify"
			   "maildir_trash"
			   "maildir_check_cur"
			   "mark_macro_prefix"
			   "mark_old"
			   "markers"
			   "mask"
			   "mbox"
			   "mbox_type"
			   "menu_context"
			   "menu_move_off"
			   "menu_scroll"
			   "message_cache_clean"
			   "message_cachedir"
			   "message_format"
			   "meta_key"
			   "mentoo"
			   "mh_purge"
			   "mh_seq_flagged"
			   "mh_seq_unseen"
			   "mime_forward"
			   "mime_forward_decode"
			   "mime_forward_rest"
			   "mime_type_query_command"
			   "mime_type_query_first"
			   "mix_entry_format"
			   "mixmaster"
			   "move"
			   "narrow_tree"
			   "net_inc"
			   "new_mail_command"
			   "pager"
			   "pager_context"
			   "pager_format"
			   "pager_index_lines"
			   "pager_stop"
			   "pgp_auto_decode"
			   "pgp_autoinline"
			   "pgp_check_exit"
			   "pgp_check_gpg_decrypt_status_fd"
			   "pgp_clearsign_command"
			   "pgp_decode_command"
			   "pgp_decrypt_command"
			   "pgp_decryption_okay"
			   "pgp_default_key"
			   "pgp_encrypt_only_command"
			   "pgp_encypt_sign_command"
			   "pgp_entry_format"
			   "pgp_export_format"
			   "pgp_getkeys_command"
			   "pgp_good_sign"
			   "pgp_import_command"
			   "pgp_list_pubring_command"
			   "pgp_list_secring_command"
			   "pgp_long_ids"
			   "pgp_mime_auto"
			   "pgp_replyinline"
			   "pgp_retainable_sigs"
			   "pgp_self_encrypt"
			   "pgp_show_unusable"
			   "pgp_sign_as"
			   "pgp_sign_command"
			   "pgp_sort_keys"
			   "pgp_strict_enc"
			   "pgp_timeout"
			   "pgp_use_gpg_agent"
			   "pgp_verify_command"
			   "pgp_verify_key_command"
			   "pipe_decode"
			   "pipe_sep"
			   "pipe_split"
			   "pop_auth_try_all"
			   "pop_authenticators"
			   "pop_checkinterval"
			   "pop_delete"
			   "pop_host"
			   "pop_oauth_refresh_command"
			   "pop_pass"
			   "pop_reconnect"
			   "pop_user"
			   "post_ident_string"
			   "postpone"
			   "postponed"
			   "postpone_encrypt"
			   "postpone_encrypt_as"
			   "preconnect"
			   "print"
			   "print_command"
			   "print_decode"
			   "print_split"
			   "prompt_after"
			   "query_command"
			   "query_format"
			   "quit"
			   "quote_regexp"
			   "read_inc"
			   "read_only"
			   "realname"
			   "recall"
			   "record"
			   "reflow_space_quotes"
			   "reflow_text"
			   "reflow_wrap"
			   "reply_regexp"
			   "reply_self"
			   "reply_to"
			   "resolve"
			   "resume_draft_files"
			   "resume_edited_draft_files"
			   "reverse_alias"
			   "reverse_name"
			   "reverse_realname"
			   "rfc2047_parameters"
			   "save_address"
			   "save_empty"
			   "save_history"
			   "save_name"
			   "score"
			   "score_threshold_delete"
			   "score_threshold_flag"
			   "score_threshold_read"
			   "search_context"
			   "send_charset"
			   "sendmail"
			   "sendmail_wait"
			   "shell"
			   "sidebar_delim_chars"
			   "sidebar_divider_char"
			   "sidebar_folder_indent"
			   "sidebar_format"
			   "sidebar_indent_string"
			   "sidebar_new_mail_only"
			   "sidebar_next_new_wrap"
			   "sidebar_short_path"
			   "sidebar_sort_method"
			   "sidebar_visible"
			   "sidebar_width"
			   "sidebar_divider"
			   "sidebar_flagged"
			   "sidebar_highlight"
			   "sidebar_indicator"
			   "sidebar_new"
			   "sidebar_ordinary"
			   "sidebar_spoolfile"
			   "sig_dashes"
			   "sig_on_top"
			   "signature"
			   "simple_search"
			   "sleep_time"
			   "smart_wrap"
			   "smileys"
			   "smime_ask_cert_label"
			   "smime_ca_location"
			   "smime_certificates"
			   "smime_decrypt_command"
			   "smime_decrypt_use_default_key"
			   "smime_default_key"
			   "smime_encrypt_command"
			   "smime_encrypt_with"
			   "smime_get_cert_command"
			   "smime_get_cert_email_command"
			   "smime_get_signer_cert_command"
			   "smime_import_cert_command"
			   "smime_is_default"
			   "smime_keys"
			   "smime_pk7out_command"
			   "smime_self_encrypt"
			   "smime_sign_as"
			   "smime_sign_command"
			   "smime_sign_digest_alg"
			   "smime_sign_opaque_command"
			   "smime_timeout"
			   "smime_verify_command"
			   "smime_verify_opaque_command"
			   "smtp_authenticators"
			   "smtp_oauth_refresh_command"
			   "smtp_pass"
			   "smtp_url"
			   "sort"
			   "sort_alias"
			   "sort_aux"
			   "sort_browser"
			   "sort_re"
			   "spam_browser"
			   "spoolfile"
			   "ssl_ca_certificates_file"
			   "ssl_client_cert"
			   "ssl_force_tls"
			   "ssl_min_dh_prime_bits"
			   "ssl_starttls"
			   "ssl_use_sslv2"
			   "ssl_use_sslv3"
			   "ssl_use_tlsv1"
			   "ssl_use_tlsv1_1"
			   "ssl_use_tlsv1_2"
			   "ssl_usesystemcerts"
			   "ssl_verify_dates"
			   "ssl_verify_host"
			   "ssl_verify_partial_chains"
			   "ssl_ciphers"
			   "status_chars"
			   "status_format"
			   "status_on_top"
			   "strict_threads"
			   "suspend"
			   "text_flowed"
			   "thorough_search"
			   "thread_received"
			   "tilde"
			   "time_inc"
			   "timeout"
			   "tmpdir"
			   "to_chars"
			   "trash"
			   "ts_icon_format"
			   "ts_enabled"
			   "ts_status_format"
			   "tunnel"
			   "uncollapse_jump"
			   "uncollapse_new"
			   "use_8bitmime"
			   "use_domain"
			   "use_envelope_from"
			   "use_from"
			   "use_ipv6"
			   "user_agent"
			   "visual"
			   "wait_key"
			   "weed"
			   "wrap"
			   "wrap_headers"
			   "wrap_search"
			   "wrapmargin"
			   "write_bcc"
			   "write_inc"
			   ))
	    (x-events '("<return>"
			"<tab>"
			"<backtab>"
			"<esc>"
			"<up>"
			"<down>"
			"<left>"
			"<right>"
			"<pageup>"
			"<pagedown>"
			"<backspace>"
			"<delete>"
			"<insert>"
			"<enter>"
			"<return>"
			"<home>"
			"<end>"
			"<space>"
			"<f1>"
			"<f2>"
			"<f3>"
			"<f4>"
			"<f5>"
			"<f6>"
			"<f7>"
			"<f8>"
			"<f9>"
			"<f10>"
			"<f11>"
			"<f12>"
			"<Return>"
			;; "\\t"
			"<Tab>"
			"<BackTab>"
			;; "\\r"
			;; "\\n"
			;; "\\e"
			"<Esc>"
			"<Up>"
			"<Down>"
			"<Left>"
			"<Right>"
			"<PageUp>"
			"<PageDown>"
			"<BackSpace>"
			"<Delete>"
			"<Insert>"
			"<Enter>"
			"<Return>"
			"<Home>"
			"<End>"
			"<Space>"
			"<F1>"
			"<F2>"
			"<F3>"
			"<F4>"
			"<F5>"
			"<F6>"
			"<F7>"
			"<F8>"
			"<F9>"
			"<F10>"
			"<F11>"
			"<F12>"))
	    (x-functions (mapcar (lambda (s) (concat "<" s ">"))
				 '("top-page"
				   "next-entry"
				   "previous-entry"
				   "bottom-page"
				   "refresh"
				   "middle-page"
				   "search-next"
				   "exit"
				   "tag-entry"
				   "next-page"
				   "previous-page"
				   "last-entry"
				   "first-entry"
				   "enter-command"
				   "next-line"
				   "previous-line"
				   "half-up"
				   "half-down"
				   "help"
				   "tag-prefix"
				   "tag-prefix-cond"
				   "end-cond"
				   "shell-escape"
				   "select-entry"
				   "search"
				   "search-reverse"
				   "search-opposite"
				   "jump"
				   "current-top"
				   "current-middle"
				   "current-bottom"
				   "error-history"
				   "what-key"
				   "check-stats"
				   "create-alias"
				   "bounce-message"
				   "break-thread"
				   "change-folder"
				   "change-folder-readonly"
				   "next-unread-mailbox"
				   "collapse-thread"
				   "collapse-all"
				   "compose-to-sender"
				   "copy-message"
				   "decode-copy"
				   "decode-save"
				   "delete-message"
				   "delete-pattern"
				   "delete-thread"
				   "delete-subthread"
				   "edit"
				   "edit-label"
				   "edit-type"
				   "forward-message"
				   "flag-message"
				   "group-reply"
				   "fetch-mail"
				   "imap-fetch-mail"
				   "imap-logout-all"
				   "display-toggle-weed"
				   "next-undeleted"
				   "limit"
				   "link-threads"
				   "list-reply"
				   "mail"
				   "toggle-new"
				   "toggle-write"
				   "next-thread"
				   "next-subthread"
				   "purge-message"
				   "query"
				   "quit"
				   "reply"
				   "show-limit"
				   "sort-mailbox"
				   "sort-reverse"
				   "print-message"
				   "previous-thread"
				   "previous-subthread"
				   "recall-message"
				   "read-thread"
				   "read-subthread"
				   "resend-message"
				   "save-message"
				   "tag-pattern"
				   "tag-subthread"
				   "tag-thread"
				   "untag-pattern"
				   "undelete-message"
				   "undelete-pattern"
				   "undelete-subthread"
				   "undelete-subthread"
				   "undelete-thread"
				   "view-attachments"
				   "show-version"
				   "set-flag"
				   "clear-flag"
				   "display-message"
				   "mark-message"
				   "buffy-list"
				   "sync-mailbox"
				   "display-address"
				   "pipe-message"
				   "next-new"
				   "next-new-then-unread"
				   "previous-new"
				   "previous-new-then-unread"
				   "next-unread"
				   "previous-unread"
				   "parent-message"
				   "root-message"
				   "extract-key"
				   "forget-passphrase"
				   "check-traditional-pgp"
				   "mail-key"
				   "decrypt-copy"
				   "decrypt-save"
				   "sidebar-new"
				   "sidebar-next"
				   "sidebar-next-new"
				   "sidebar-open"
				   "sidebar-page-down"
				   "sidebar-page-up"
				   "sidebar-prev"
				   "sidebar-prev-new"
				   "sidebar-toggle-visible"
				   "break-thread"
				   "create-alias"
				   "bounce-message"
				   "change-folder"
				   "change-folder-readonly"
				   "next-unread-mailbox"
				   "compose-to-sender"
				   "copy-message"
				   "decode-copy"
				   "delete-message"
				   "delete-thread"
				   "delete-subthread"
				   "set-flag"
				   "clear-flag"
				   "edit"
				   "edit-label"
				   "edit-type"
				   "forward-message"
				   "flag-message"
				   "group-reply"
				   "imap-fetch-mail"
				   "imap-logout-all"
				   "display-toggle-weed"
				   "next-undeleted"
				   "next-entry"
				   "previous-undeleted"
				   "previous-entry"
				   "link-threads"
				   "list-reply"
				   "redraw-screen"
				   "mail"
				   "mark-as-new"
				   "search-next"
				   "next-thread"
				   "next-subthread"
				   "sort-mailbox"
				   "sort-reverse"
				   "print-message"
				   "previous-thread"
				   "previous-subthread"
				   "purge-message"
				   "quit"
				   "exit"
				   "reply"
				   "recall-message"
				   "read-thread"
				   "read-subthread"
				   "resend-message"
				   "save-message"
				   "skip-quoted"
				   "decode-save"
				   "tag-message"
				   "toggle-quoted"
				   "undelete-message"
				   "undelete-subthread"
				   "undelete-thread"
				   "view-attachments"
				   "show-version"
				   "search-toggle"
				   "display-address"
				   "next-new"
				   "pipe-message"
				   "help"
				   "next-page"
				   "previous-page"
				   "top"
				   "sync-mailbox"
				   "shell-escape"
				   "enter-command"
				   "buffy-list"
				   "search"
				   "search-reverse"
				   "search-opposite"
				   "next-line"
				   "error-history"
				   "jump"
				   "next-unread"
				   "previous-new"
				   "previous-unread"
				   "half-up"
				   "half-down"
				   "previous-line"
				   "bottom"
				   "parent-message"
				   "root-message"
				   "check-traditional-pgp"
				   "mail-key"
				   "extract-key"
				   "forget-passphrase"
				   "decrypt-copy"
				   "decrypt-save"
				   "what-key"
				   "check-stats"
				   "sidebar-next"
				   "sidebar-next-new"
				   "sidebar-open"
				   "sidebar-open"
				   "sidebar-page-down"
				   "sidebar-page-up"
				   "sidebar-prev"
				   "sidebar-prev-new"
				   "sidebar-toggle-visible"
				   "delete-entry"
				   "undelete-entry"
				   "create-alias"
				   "mail"
				   "query"
				   "query-append"
				   "bounce-message"
				   "display-toggle-weed"
				   "compose-to-sender"
				   "edit-type"
				   "print-entry"
				   "save-entry"
				   "pipe-entry"
				   "view-mailcap"
				   "reply"
				   "resend-message"
				   "group-reply"
				   "list-reply"
				   "forward-message"
				   "view-text"
				   "view-attach"
				   "delete-entry"
				   "undelete-entry"
				   "collapse-parts"
				   "check-traditional-pgp"
				   "extract-key"
				   "forget-passphrase"
				   "attach-file"
				   "attach-message"
				   "edit-bcc"
				   "edit-cc"
				   "copy-file"
				   "detach-file"
				   "toggle-disposition"
				   "edit-description"
				   "edit-message"
				   "edit-headers"
				   "edit-file"
				   "edit-encoding"
				   "edit-from"
				   "edit-fcc"
				   "filter-entry"
				   "get-attachment"
				   "display-toggle-weed"
				   "ispell"
				   "print-entry"
				   "edit-mime"
				   "new-mime"
				   "postpone-message"
				   "edit-reply-to"
				   "rename-attachment"
				   "rename-file"
				   "edit-subject"
				   "edit-to"
				   "edit-type"
				   "write-fcc"
				   "toggle-unlink"
				   "toggle-recode"
				   "update-encoding"
				   "view-attach"
				   "send-message"
				   "pipe-entry"
				   "attach-key"
				   "pgp-menu"
				   "forget-passphrase"
				   "smime-menu"
				   "mix"
				   "delete-entry"
				   "undelete-entry"
				   "change-dir"
				   "display-filename"
				   "enter-mask"
				   "sort"
				   "sort-reverse"
				   "select-new"
				   "check-new"
				   "toggle-mailboxes"
				   "view-file"
				   "buffy-list"
				   "create-mailbox"
				   "delete-mailbox"
				   "rename-mailbox"
				   "subscribe"
				   "unsubscribe"
				   "toggle-subscribed"
				   "verify-key"
				   "view-name"
				   "verify-key"
				   "verify-name"
				   "accept"
				   "append"
				   "insert"
				   "delete"
				   "chain-prev"
				   "chain-next"
				   "bol"
				   "backward-char"
				   "backward-word"
				   "capitalize-word"
				   "downcase-word"
				   "delete-char"
				   "eol"
				   "forward-char"
				   "forward-word"
				   "backspace"
				   "kill-eol"
				   "kill-eow"
				   "kill-line"
				   "quote-char"
				   "kill-word"
				   "complete"
				   "complete-query"
				   "buffy-cycle"
				   "history-up"
				   "history-down"
				   "history-search"
				   "transpose-chars")))

	    (x-keywords-regexp (concat "\\(^[ ]*\\|.*;[ ]*\\)\\(" (regexp-opt x-keywords 'words) "\\)"))
	    (x-types-regexp (concat "\\(.*=[ ]*\\)\\(" (regexp-opt x-types 'words) "\\)"))
	    ;(x-types-regexp (regexp-opt x-types 'words))
	    (x-constants-regexp (concat "\\<color[0-9]*\\>\\|" "\\<quoted[0-9]*\\>\\|" (regexp-opt x-constants 'words)))
	    (x-events-regexp (concat "\\<[a-z]\\>\\|\\<[A-z]\\>\\|" (regexp-opt x-events 'words)))
	    (x-functions-regexp (regexp-opt x-functions 'words)))

	`(
	  (,x-keywords-regexp	.	(2 font-lock-keyword-face))
	  (,x-types-regexp	.	(2 font-lock-type-face))
	  (,x-constants-regexp	.	font-lock-constant-face)
	  (,x-events-regexp	.	font-lock-builtin-face)
	  (,x-functions-regexp	.	font-lock-function-name-face)

	  )))

;;;###autoload
(define-derived-mode mutt-mode prog-mode "mutt"
  "Major mode for editing mutt configuration files."
  (setq font-lock-defaults '((mutt-font-lock-keywords))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.muttrc\\". mutt-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\<muttrc\\>". mutt-mode))

(provide 'mutt-mode)

;;; mutt-mode.el ends here
