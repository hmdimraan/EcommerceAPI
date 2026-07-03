USE [EcommerceDB]
GO

/****** Object:  Table [dbo].[cartitems]    Script Date: 03-07-2026 09:43:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[cartitems](
	[CartItemID] [int] IDENTITY(1,1) NOT NULL,
	[CartID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_cartitems] PRIMARY KEY CLUSTERED 
(
	[CartItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[cartitems]  WITH CHECK ADD  CONSTRAINT [FK_cartitems_carts_CartID] FOREIGN KEY([CartID])
REFERENCES [dbo].[carts] ([CartID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[cartitems] CHECK CONSTRAINT [FK_cartitems_carts_CartID]
GO

ALTER TABLE [dbo].[cartitems]  WITH CHECK ADD  CONSTRAINT [FK_cartitems_products_ProductID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[products] ([ProductID])
GO

ALTER TABLE [dbo].[cartitems] CHECK CONSTRAINT [FK_cartitems_products_ProductID]
GO


