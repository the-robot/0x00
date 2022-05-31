## accesschk_xp.exe

The latest version of `accesschk.exe` from Microsoft will hang the reverse shell because of pop up a window asking for the user to accept the EULA.
There's no issue with this version, you can simply run the command below for example.

```bash
accesschk_xp.exe /accepteula -uwcqv "Authenticated Users" *

# MD5: 520d55e8394a50e16967c93c3614ce43
```

> [Check here for the lastest version from Microsoft](https://docs.microsoft.com/en-us/sysinternals/downloads/accesschk)

## nc.exe

[Download here](https://github.com/int0x33/nc.exe/)
