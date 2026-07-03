USE [EcommerceDB]
GO

/****** Object:  Table [dbo].[payments]    Script Date: 03-07-2026 18:36:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[payments](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[PaymentMethod] [nvarchar](max) NULL,
	[PaymentDate] [datetime2](7) NULL,
	[Amount] [decimal](18, 2) NULL,
	[PaymentStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_payments] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[payments]  WITH CHECK ADD  CONSTRAINT [FK_payments_orders_OrderID] FOREIGN KEY([OrderID])
REFERENCES [dbo].[orders] ([OrderID])
GO

ALTER TABLE [dbo].[payments] CHECK CONSTRAINT [FK_payments_orders_OrderID]
GO


