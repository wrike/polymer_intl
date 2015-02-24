import 'package:intl/intl.dart';
class IntlExtract{
    String message_msg1(arg1, arg2, arg3) => Intl.message(
        "The protection \$arg1 of property rights $arg2 remains one of the most $arg3 contentious issues in $arg1 present-day Russia \$arg1.",
        name: "message_msg1",
        desc: "desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis",
        args: [arg1, arg2, arg3],
        examples: {"arg1":"test1","arg2":"test2","arg3":"test3"});

    String message_msg2_with_param(arg1, arg2, arg3) => Intl.message(
        "2The protection \$arg1 of property rights $arg2 remains one of the most $arg3 contentious issues in $arg1 present-day Russia \$arg1.",
        name: "message_msg2_with_param",locale:'EN',
        desc: "2desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis",
        args: [arg1, arg2, arg3],
        examples: {"arg1":"test1","arg2":"test2","arg3":"test3"});

    String message_msg3_without_args() => Intl.message(
        "Msg3 Only Text",
        name: "message_msg3_without_args",
        desc: "3desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis",
        args: [],
        examples: {});

    String message_msg4_without_args() => Intl.message(
        "Msg4 Only Text Engl text",
        name: "message_msg4_without_args",locale:'EN',
        desc: "4desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis",
        args: [],
        examples: {});

}