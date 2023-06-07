
class MessageEcrit {
final String name, lastMessage, image, time;
final bool isActive;

MessageEcrit({
this.name = '',
this.lastMessage = '',
this.image = '',
this.time = '',
this.isActive = false,
});
}

List chatsData = [
MessageEcrit(
name: "Amisa Aimée",
//lastMessage: "Hope you are doing well...",
image: "assets/empty.gif",
time: "3m ago",
isActive: false,
),
MessageEcrit(
name: "Esther Ongona",
//lastMessage: "Hello Abdullah! I am...",
image: "assets/empty.gif",
time: "8m ago",
isActive: true,
),
MessageEcrit(
name: "Exaucée Kumba",
//lastMessage: "Do you have update...",
image: "assets/empty.gif",
time: "5d ago",
isActive: false,
),
MessageEcrit(
name: "Josué nlandu",
//lastMessage: "You’re welcome :)",
image: "assets/empty.gif",
time: "5d ago",
isActive: true,
),
MessageEcrit(
name: "Albert Flores",
lastMessage: "Thanks",
image: "assets/empty.gif",
time: "6d ago",
isActive: false,
),
MessageEcrit(
name: "Jenny Wilson",
//lastMessage: "Hope you are doing well...",
image: "assets/empty.gif",
time: "3m ago",
isActive: false,
),
MessageEcrit(
name: "Esther Howard",
//lastMessage: "Hello Abdullah! I am...",
image: "assets/empty.gif",
time: "8m ago",
isActive: true,
),
MessageEcrit(
name: "Ralph Edwards",
//lastMessage: "Do you have update...",
image: "assets/empty.gif",
time: "5d ago",
isActive: false,
),
];