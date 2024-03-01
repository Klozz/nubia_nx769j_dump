#!/system/bin/sh

if [ "$(getprop persist.sys.stc)" = "true" ]; then
    setprop log.tag ""
    exit 0
fi

if [ "x$(getprop persist.sys.ztelog.enable)" = "x1" ]; then
    setprop log.tag ""
    setprop log.tag.InputMethodManagerService D
    setprop log.tag.DoubleApp V
    setprop log.tag.UsageStatsService D
    setprop log.tag.zteSecurityImeHelp D
    setprop log.tag.ImeFocusController D
    setprop log.tag.InputMethodManager D
    setprop log.tag.ViewRootImpl D
    setprop log.tag.DefaultImeVisibilityApplier D
    setprop log.tag.APM_AudioPolicyManager D
    setprop log.tag.stats_log I
    setprop log.tag.Watchdog I
    setprop persist.log.tag.Telecom D
    setprop persist.log.tag.AndroidRuntime D
    setprop persist.log.tag.LIB_DEBUG D
    setprop persist.log.tag.RenderEngine I

else
    setprop log.tag S
    setprop log.tag.InputMethodManagerService S
    setprop log.tag.DoubleApp S
    setprop log.tag.UsageStatsService S
    setprop log.tag.zteSecurityImeHelp S
    setprop log.tag.ImeFocusController S
    setprop log.tag.InputMethodManager S
    setprop log.tag.ViewRootImpl S
    setprop log.tag.DefaultImeVisibilityApplier S
    setprop log.tag.APM_AudioPolicyManager S
    setprop log.tag.stats_log S
    setprop persist.log.tag.Telecom S
    setprop persist.log.tag.RenderEngine S
fi


