import 'package:intl/intl.dart';
class IntlExtract{
    String message_M1A5CD3D2(arg1, arg2, arg3) => Intl.message(
        "The protection \$arg1 of property rights $arg2 remains one of the most $arg3 contentious issues in $arg1 present-day Russia \$arg1.",
        name: "message_M1A5CD3D2",
        desc: "desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis",
        args: [arg1, arg2, arg3],
        examples: {"arg1":"test1","arg2":"test2","arg3":"test3"});

    String message_M6BFCF944(arg1, arg2, arg3) => Intl.message(
        "2The protection \$arg1 of property rights $arg2 remains one of the most $arg3 contentious issues in $arg1 present-day Russia \$arg1.",
        name: "message_M6BFCF944",locale:'EN',
        desc: "2desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis",
        args: [arg1, arg2, arg3],
        examples: {"arg1":"test1","arg2":"test2","arg3":"test3"});

    String message_M1AD1908D() => Intl.message(
        "Msg3 Only Text",
        name: "message_M1AD1908D",
        desc: "3desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis",
        args: [],
        examples: {});

    String gender_M14CE376(arg1, arg2) => Intl.gender(
        "4The protection \$arg1 of property rights $arg2 remains one of the most \$arg3 contentious issues in $arg1 present-day Russia \$arg1.",
        name: "gender_M14CE376",
        male: "male",
        female: "female",
        other: "other",
        desc: "4desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis",
        args: [arg1, arg2],
        examples: {"arg1":"test1","arg2":"test2"});

    String plural_6666BE12(arg1, arg2) => Intl.plural(
        3,
        name: "plural_6666BE12",
        zero: "zero",
        one: "one",
        two: "two",
        few: "few",
        many: "many",
        other: "other",
        desc: "5desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis",
        args: [arg1, arg2],
        examples: {"arg1":"test1","arg2":"test2"});

}