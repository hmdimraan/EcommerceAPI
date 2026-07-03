USE [EcommerceDB]
GO

/****** Object:  Table [dbo].[orderdetails]    Script Date: 03-07-2026 18:35:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[orderdetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_orderdetails] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[orderdetails]  WITH CHECK ADD  CONSTRAINT [FK_orderdetails_orders_OrderID] FOREIGN KEY([OrderID])
REFERENCES [dbo].[orders] ([OrderID])
GO

ALTER TABLE [dbo].[orderdetails] CHECK CONSTRAINT [FK_orderdetails_orders_OrderID]
GO

ALTER TABLE [dbo].[orderdetails]  WITH CHECK ADD  CONSTRAINT [FK_orderdetails_products_ProductID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[products] ([ProductID])
GO

ALTER TABLE [dbo].[orderdetails] CHECK CONSTRAINT [FK_orderdetails_products_ProductID]
GO


