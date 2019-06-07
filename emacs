;;; EMACS CONFIG ;;;

;; REPOSITORIES
(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(package-initialize)

;; -----------------------------------------------------------------------------

;; CUSTOM VARIABLES
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (base16-eighties)))
 '(custom-safe-themes
   (quote
    ("e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" "3e34e9bf818cf6301fcabae2005bba8e61b1caba97d95509c8da78cff5f2ec8e" "1d079355c721b517fdc9891f0fda927fe3f87288f2e6cc3b8566655a64ca5453" "dd4628d6c2d1f84ad7908c859797b24cc6239dfe7d71b3363ccdd2b88963f336" "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "c968804189e0fc963c641f5c9ad64bca431d41af2fb7e1d01a2a6666376f819c" "85e6bb2425cbfeed2f2b367246ad11a62fb0f6d525c157038a0d0eaaabc1bfee" "85d609b07346d3220e7da1e0b87f66d11b2eeddad945cac775e80d2c1adb0066" "aded4ec996e438a5e002439d58f09610b330bbc18f580c83ebaba026bbef6c82" "34ed3e2fa4a1cb2ce7400c7f1a6c8f12931d8021435bad841fdc1192bd1cc7da" "ffe80c88e3129b2cddadaaf78263a7f896d833a77c96349052ad5b7753c0c5a5" "cbd8e65d2452dfaed789f79c92d230aa8bdf413601b261dbb1291fb88605110c" "9c4acf7b5801f25501f0db26ac3eee3dc263ed51afd01f9dcfda706a15234733" "b8929cff63ffc759e436b0f0575d15a8ad7658932f4b2c99415f3dde09b32e97" "cea3ec09c821b7eaf235882e6555c3ffa2fd23de92459751e18f26ad035d2142" "9be1d34d961a40d94ef94d0d08a364c3d27201f3c98c9d38e36f10588469ea57" "4be83a66a817a396b26baafc70e73f52c53dd1ca4ced4c2085c7dff109ff0b99" "4f2ede02b3324c2f788f4e0bad77f7ebc1874eff7971d2a2c9b9724a50fb3f65" "e3bf16af35586816b824bea36188215319b1cceb208d3518700d876c4c1a9cc7" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" default)))
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (anaconda-mode lua-mode flycheck-pos-tip flycheck-color-mode-line base16-theme fill-column-indicator paredit rainbow-delimiters company-anaconda helm evil nyan-mode flycheck heroku-theme python-mode)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; -----------------------------------------------------------------------------

;; GENERAL CONFIGURATIONS FOR EMACS GNU

; Set line at 80 characters
(require 'fill-column-indicator)
(setq fci-rule-column 79)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

; ido, for auto-completing when searching files and buffers
(require 'ido)
(ido-mode t)

; Start in fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

; Hide scroll-bar
(toggle-scroll-bar -1)

; Always use spaces, not tabs, when indenting
(setq indent-tabs-mode nil)

; Ignore case when searching
(setq case-fold-search t)

; Don't show the startup screen
(setq inhibit-startup-screen t)

; Display line numbers to the right of the window
(global-linum-mode t)

; Show the current line and column numbers in the stats bar as well
(line-number-mode t)
(column-number-mode t)

; Have nyan cat as your scroll bar ^3^
(nyan-mode t)

; y or n.
(defalias 'yes-or-no-p 'y-or-n-p)

; Automatic bracket insertion by pairs
(electric-pair-mode 1)

;; -----------------------------------------------------------------------------

;; MODES

;; EVIL-MODE >:)
(require 'evil)
(evil-mode 1)

; Change cursor color depending on mode
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("yellow" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("yellow" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

; Vim-like search highlighting
;; (require 'evil-search-highlight-persist)
;; (global-evil-search-highlight-persist t)

; Set the \, + <SPC> for removing the higlights (leader key)
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all)

;; COMPANY MODE
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

; Reduce the time after which the company auto completion popup opens
(setq company-idle-delay 0.2)

; the tab key may be used to indent or to autocomplete
(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
(indent-according-to-mode)))

;; FLYCHECK MODE
(add-hook 'after-init-hook #'global-flycheck-mode)

; Show flycheck errors on popups
;(eval-after-load 'flycheck
;    '(custom-set-variables
;    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
(setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)

; Color the mode line based on the flycheck state
(require 'flycheck-color-mode-line)
(eval-after-load "flycheck"
'(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;; -----------------------------------------------------------------------------

;; PROGRAMMING LANGUAGE SPECIFIC MODES

;; PYTHON MODE

; General
 (add-hook 'python-mode-hook 'rainbow-delimiters-mode)

; Anaconda: needs an inferior Python process to complete built-in definitions
(add-hook 'python-mode-hook 'run-python-once)
(defun run-python-once ()
  (remove-hook 'python-mode-hook 'run-python-once)
  (run-python))

; Anaconda for company
(eval-after-load "company" '(add-to-list 'company-backends 'company-anaconda))
(add-hook 'python-mode-hook 'anaconda-mode)

; set flake8 as the default linter
(defun enable-flake8 ()
  (setq flycheck-checker 'python-flake8)
  (setq flycheck-python-flake8-executable "/usr/bin/flake8"))
(add-hook 'python-mode-hook 'enable-flake8)

;; ; paredit for python (parenthesis autocompletion)
;; (add-hook 'python-mode-hook #'enable-paredit-mode)

;;; .emacs ends here
