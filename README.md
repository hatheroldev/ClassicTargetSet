# ClassicTargetSet

Use `/cts macroname` to set current target in macro `macroname`.

Use `/ctsample` to generate the following sample macro:

```
#showtooltip [nomod] Verwandlung
/target [nomod] x
/stopcasting [nomod,exists,harm]
/spell [nomod,exists,harm] Verwandlung
/stopmacro [nomod]
/cts cts1
```

This macro, if no modifier is pressed:
  - changes the target (here the placeholder `x`),
  - stops all current channeled spells,
  - casts a spell (here `Verwandlung`).

If a modifier is pressed (`alt`, `ctrl` or `shift`):
  - is sets the current target as new macro target (it replaces `x`),
  - **note**: this works only if you are not in combat and and can not be used with mobs as target (the target name must be unique).

You should:
  - rename that macro and replace `cts1` in the last line with the new macro name,
  - replace the spell `Verwandlung` with a spell of your choice.

The macro is meant as a sort of **urgent and quick focus cast** on players, like the tank.

It also works on NPCs with unique names.
