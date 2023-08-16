/*
  Warnings:

  - You are about to drop the `tbl_owner` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "PLANTYPE" AS ENUM ('MONTHLY', 'YEARLY');

-- CreateEnum
CREATE TYPE "ROLE" AS ENUM ('OWNER', 'USER', 'CO_OWNER');

-- DropTable
DROP TABLE "tbl_owner";

-- CreateTable
CREATE TABLE "tbl_owners" (
    "id" TEXT NOT NULL,
    "shopName" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "planType" "PLANTYPE" NOT NULL DEFAULT 'MONTHLY',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "address" TEXT,

    CONSTRAINT "tbl_owners_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_items" (
    "id" TEXT NOT NULL,
    "billingID" TEXT NOT NULL,
    "productID" TEXT NOT NULL,
    "qty" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    "discount" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tbl_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_billing" (
    "id" TEXT NOT NULL,
    "shopID" TEXT NOT NULL,
    "total" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tbl_billing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_product" (
    "id" TEXT NOT NULL,
    "shopID" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "descriptions" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tbl_product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_user" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" "ROLE" NOT NULL DEFAULT 'USER',
    "email" TEXT,
    "mobile" TEXT,
    "shopID" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tbl_user_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "tbl_items" ADD CONSTRAINT "tbl_items_billingID_fkey" FOREIGN KEY ("billingID") REFERENCES "tbl_billing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_billing" ADD CONSTRAINT "tbl_billing_shopID_fkey" FOREIGN KEY ("shopID") REFERENCES "tbl_owners"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_product" ADD CONSTRAINT "tbl_product_shopID_fkey" FOREIGN KEY ("shopID") REFERENCES "tbl_owners"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_user" ADD CONSTRAINT "tbl_user_shopID_fkey" FOREIGN KEY ("shopID") REFERENCES "tbl_owners"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
