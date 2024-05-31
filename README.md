Deploying this flow config results in a crash on the emulator:

```
➜  flow-json-deploy git:(main) ✗ flow-c1 project deploy

Deploying 1 contracts for accounts: emulator-account


❌ Crash detected!

✔ No

Please help us improve the Flow CLI by opening an issue on https://github.com/onflow/flow-cli/issues,
and pasting the output as well as a description of the actions you took that resulted in this crash.

runtime error: invalid memory address or nil pointer dereference
[] []
map[device:map[arch:arm64 num_cpu:16] os:map[name:darwin] runtime:map[go_maxprocs:16 go_numcgocalls:13 go_numroutines:30 name:go version:go1.20]]
goroutine 1 [running]:
runtime/debug.Stack()
	/usr/local/go/src/runtime/debug/stack.go:24 +0x64
github.com/onflow/flow-cli/internal/command.initCrashReporting.func1(0x1400035a580, 0x1400068f200)
	/go/src/github.com/onflow/flow-cli/internal/command/command.go:395 +0x1c8
github.com/getsentry/sentry-go.(*Client).processEvent(0x140004e14a0, 0x1400035a580?, 0x1400068f200, {0x102b89a00, 0x140001d7680})
	/root/go/pkg/mod/github.com/getsentry/sentry-go@v0.27.0/client.go:631 +0x24c
github.com/getsentry/sentry-go.(*Client).CaptureEvent(...)
	/root/go/pkg/mod/github.com/getsentry/sentry-go@v0.27.0/client.go:447
github.com/getsentry/sentry-go.(*Client).RecoverWithContext(0x60?, {0x0?, 0x0}, {0x1027aa000?, 0x103fbc3c0?}, 0x100cd36e8?, {0x102b89a00, 0x140001d7680})
	/root/go/pkg/mod/github.com/getsentry/sentry-go@v0.27.0/client.go:498 +0x1e4
github.com/getsentry/sentry-go.(*Client).Recover(0xeb?, {0x1027aa000?, 0x103fbc3c0?}, 0x0?, {0x102b89a00?, 0x140001d7680?})
	/root/go/pkg/mod/github.com/getsentry/sentry-go@v0.27.0/client.go:462 +0x80
github.com/getsentry/sentry-go.(*Hub).Recover(0x1?, {0x1027aa000?, 0x103fbc3c0?})
	/root/go/pkg/mod/github.com/getsentry/sentry-go@v0.27.0/hub.go:330 +0xc0
github.com/getsentry/sentry-go.Recover()
	/root/go/pkg/mod/github.com/getsentry/sentry-go@v0.27.0/sentry.go:68 +0x40
panic({0x1027aa000, 0x103fbc3c0})
	/usr/local/go/src/runtime/panic.go:884 +0x1f4
github.com/onflow/flowkit/v2/transactions.addAccountContractWithArgs(0x140007e68a0, {{0x14000d16978?, 0x90?}, {0x14000191050?, 0x1?}}, {0x140007e2870, 0x1, 0x11?})
	/root/go/pkg/mod/github.com/onflow/flowkit/v2@v2.0.0-stable-cadence-alpha.20/transactions/transaction.go:121 +0x2f8
github.com/onflow/flowkit/v2/transactions.NewAddAccountContract(...)
	/root/go/pkg/mod/github.com/onflow/flowkit/v2@v2.0.0-stable-cadence-alpha.20/transactions/transaction.go:82
github.com/onflow/flowkit/v2.(*Flowkit).AddContract(0x1400068ea80, {0x102ba5e40, 0x1400012c008}, 0x140007e68a0, {{0x1400060e2c0, 0x90, 0x290}, {0x140007e2870, 0x1, 0x1}, ...}, ...)
	/root/go/pkg/mod/github.com/onflow/flowkit/v2@v2.0.0-stable-cadence-alpha.20/flowkit.go:305 +0x234
github.com/onflow/flowkit/v2.(*Flowkit).DeployProject(0x1400068ea80, {0x102ba5e40, 0x1400012c008}, 0x102baafa0?)
	/root/go/pkg/mod/github.com/onflow/flowkit/v2@v2.0.0-stable-cadence-alpha.20/flowkit.go:739 +0x424
github.com/onflow/flow-cli/internal/project.deploy({0x0?, 0x0?, 0x0?}, {{0x0, 0x0}, {0x101e44888, 0x4}, {0x0, 0x0}, {0x0, ...}, ...}, ...)
	/go/src/github.com/onflow/flow-cli/internal/project/deploy.go:79 +0x104
github.com/onflow/flow-cli/internal/command.Command.AddToParent.func1(0x103ff5080?, {0x10405a4b0, 0x0, 0x0})
	/go/src/github.com/onflow/flow-cli/internal/command/command.go:149 +0x528
github.com/spf13/cobra.(*Command).execute(0x103ff5080, {0x1400011a1a0, 0x0, 0x0})
	/root/go/pkg/mod/github.com/spf13/cobra@v1.8.0/command.go:987 +0x798
github.com/spf13/cobra.(*Command).ExecuteC(0x14000712c00)
	/root/go/pkg/mod/github.com/spf13/cobra@v1.8.0/command.go:1115 +0x364
github.com/spf13/cobra.(*Command).Execute(...)
	/root/go/pkg/mod/github.com/spf13/cobra@v1.8.0/command.go:1039
main.main()
	/go/src/github.com/onflow/flow-cli/cmd/flow/main.go:136 +0xd5c
```

The json itself seems to be valid because I can submit it in a transaction just fine:

transaction:
```
transaction(data: {String: AnyStruct}) {
    prepare(acct: &Account) {
        log(data)
    }
}
```

output:
```
➜  flow-json-deploy git:(main) ✗ flow transactions send ./transactions/send_dictionary.cdc --args-json "$(cat ./args/send_dictionary.json)"
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                           ⚠ Upgrade to Cadence 1.0
     The Crescendo network upgrade, including Cadence 1.0, is coming soon.
     You may need to update your existing contracts to support this change.
                     Please visit our migration guide here:
             https://cadence-lang.org/docs/cadence_migration_guide
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

❗   Version warning: a new version of Flow CLI is available (v1.18.0).
   Read the installation guide for upgrade instructions: https://docs.onflow.org/flow-cli/install

Transaction ID: ab95904a973c958ff1a28710b51b605862714e81fa09401e18980d0580479031

Block ID	3cdbad37f4e5bdb604e7dbf061b699edef8897c25cc1c48f8748fa1d815a58ae
Block Height	1
Status		✅ SEALED
ID		ab95904a973c958ff1a28710b51b605862714e81fa09401e18980d0580479031
Payer		f8d6e0586b0a20c7
Authorizers	[f8d6e0586b0a20c7]

Proposal Key:
    Address	f8d6e0586b0a20c7
    Index	0
    Sequence	0

No Payload Signatures

Envelope Signature 0: f8d6e0586b0a20c7
Signatures (minimized, use --include signatures)

Events:	 None


Code (hidden, use --include code)

Payload (hidden, use --include payload)

Fee Events (hidden, use --include fee-events)
```