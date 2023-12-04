-- CreateTable
CREATE TABLE "Guest" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,

    CONSTRAINT "Guest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ConfirmedGuest" (
    "id" SERIAL NOT NULL,
    "guestId" INTEGER NOT NULL,
    "eventListId" INTEGER,

    CONSTRAINT "ConfirmedGuest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EventList" (
    "id" SERIAL NOT NULL,
    "list_name" TEXT NOT NULL,
    "num_guests" INTEGER NOT NULL,

    CONSTRAINT "EventList_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_EventListToGuest" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Guest_phone_number_key" ON "Guest"("phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "ConfirmedGuest_guestId_key" ON "ConfirmedGuest"("guestId");

-- CreateIndex
CREATE UNIQUE INDEX "EventList_list_name_key" ON "EventList"("list_name");

-- CreateIndex
CREATE UNIQUE INDEX "_EventListToGuest_AB_unique" ON "_EventListToGuest"("A", "B");

-- CreateIndex
CREATE INDEX "_EventListToGuest_B_index" ON "_EventListToGuest"("B");

-- AddForeignKey
ALTER TABLE "ConfirmedGuest" ADD CONSTRAINT "ConfirmedGuest_guestId_fkey" FOREIGN KEY ("guestId") REFERENCES "Guest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ConfirmedGuest" ADD CONSTRAINT "ConfirmedGuest_eventListId_fkey" FOREIGN KEY ("eventListId") REFERENCES "EventList"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventListToGuest" ADD CONSTRAINT "_EventListToGuest_A_fkey" FOREIGN KEY ("A") REFERENCES "EventList"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventListToGuest" ADD CONSTRAINT "_EventListToGuest_B_fkey" FOREIGN KEY ("B") REFERENCES "Guest"("id") ON DELETE CASCADE ON UPDATE CASCADE;
