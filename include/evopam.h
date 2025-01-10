//
// Created by ethan on 9/6/24.
//

#ifndef PAM_H
#define PAM_H

#include <security/pam_appl.h>
#include <security/pam_modules.h>
#include <security/pam_ext.h>

/**
 * @brief Drop in replacement for `pam_sm_authenticate`
 * @param pamh
 * @param flags
 * @param argc
 * @param argv
 * @return
 */
PAM_EXTERN int authenticate(pam_handle_t *pamh, int flags, int argc, const char **argv);

#endif //PAM_H