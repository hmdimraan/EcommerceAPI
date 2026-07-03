USE [master]
GO
/****** Object:  Database [EcommerceDB]    Script Date: 03-07-2026 19:23:09 ******/
CREATE DATABASE [EcommerceDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EcommerceDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\EcommerceDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'EcommerceDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\EcommerceDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [EcommerceDB] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EcommerceDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EcommerceDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EcommerceDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EcommerceDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EcommerceDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EcommerceDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EcommerceDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [EcommerceDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EcommerceDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EcommerceDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EcommerceDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EcommerceDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EcommerceDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EcommerceDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EcommerceDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EcommerceDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EcommerceDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EcommerceDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EcommerceDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EcommerceDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EcommerceDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EcommerceDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [EcommerceDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EcommerceDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EcommerceDB] SET  MULTI_USER 
GO
ALTER DATABASE [EcommerceDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EcommerceDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EcommerceDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EcommerceDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EcommerceDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EcommerceDB] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [EcommerceDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [EcommerceDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [EcommerceDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [EcommerceDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 03-07-2026 19:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cartitems]    Script Date: 03-07-2026 19:23:09 ******/
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
/****** Object:  Table [dbo].[carts]    Script Date: 03-07-2026 19:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[carts](
	[CartID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_carts] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 03-07-2026 19:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderdetails]    Script Date: 03-07-2026 19:23:09 ******/
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
/****** Object:  Table [dbo].[orders]    Script Date: 03-07-2026 19:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[OrderDate] [datetime2](7) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payments]    Script Date: 03-07-2026 19:23:09 ******/
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
/****** Object:  Table [dbo].[products]    Script Date: 03-07-2026 19:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Stock] [int] NOT NULL,
	[ProductImagePath] [nvarchar](max) NULL,
	[CategoryID] [int] NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 03-07-2026 19:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 03-07-2026 19:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 03-07-2026 19:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[Phone] [nvarchar](max) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260619071408_InitialCreate', N'10.0.8')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260619090659_RemoveCustomersTable', N'10.0.8')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260619094751_AddCartTables', N'10.0.8')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260621043404_FinalSchemaFix', N'10.0.8')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260621043741_FixPaymentPrecision', N'10.0.8')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260624063918_AddReviews', N'10.0.8')
GO
SET IDENTITY_INSERT [dbo].[cartitems] ON 
GO
INSERT [dbo].[cartitems] ([CartItemID], [CartID], [ProductID], [Quantity]) VALUES (5, 1, 2, 2)
GO
INSERT [dbo].[cartitems] ([CartItemID], [CartID], [ProductID], [Quantity]) VALUES (21, 3, 12, 1)
GO
INSERT [dbo].[cartitems] ([CartItemID], [CartID], [ProductID], [Quantity]) VALUES (75, 2, 12, 1)
GO
INSERT [dbo].[cartitems] ([CartItemID], [CartID], [ProductID], [Quantity]) VALUES (76, 2, 14, 1)
GO
SET IDENTITY_INSERT [dbo].[cartitems] OFF
GO
SET IDENTITY_INSERT [dbo].[carts] ON 
GO
INSERT [dbo].[carts] ([CartID], [UserID], [CreatedDate]) VALUES (1, 1, CAST(N'2026-06-19T19:49:11.9809751' AS DateTime2))
GO
INSERT [dbo].[carts] ([CartID], [UserID], [CreatedDate]) VALUES (2, 2, CAST(N'2026-06-22T19:06:18.8403261' AS DateTime2))
GO
INSERT [dbo].[carts] ([CartID], [UserID], [CreatedDate]) VALUES (3, 3, CAST(N'2026-06-24T08:57:28.4009366' AS DateTime2))
GO
INSERT [dbo].[carts] ([CartID], [UserID], [CreatedDate]) VALUES (4, 7, CAST(N'2026-06-25T17:20:08.7355263' AS DateTime2))
GO
INSERT [dbo].[carts] ([CartID], [UserID], [CreatedDate]) VALUES (5, 8, CAST(N'2026-06-26T08:25:19.3748514' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[carts] OFF
GO
SET IDENTITY_INSERT [dbo].[categories] ON 
GO
INSERT [dbo].[categories] ([CategoryID], [CategoryName]) VALUES (1, N'Mobiles')
GO
INSERT [dbo].[categories] ([CategoryID], [CategoryName]) VALUES (2, N'Earbuds')
GO
INSERT [dbo].[categories] ([CategoryID], [CategoryName]) VALUES (3, N'Accessories')
GO
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[orderdetails] ON 
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (1, 2, 2, 2, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (2, 4, 2, 2, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (3, 16, 2, 3, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (4, 17, 2, 1, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (5, 18, 4, 2, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (6, 19, 2, 1, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (7, 20, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (8, 21, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (9, 22, 2, 1, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (10, 23, 2, 4, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (11, 24, 2, 4, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (12, 24, 3, 1, CAST(70000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (13, 25, 2, 4, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (14, 25, 3, 1, CAST(70000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (15, 26, 2, 4, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (16, 26, 3, 1, CAST(70000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (17, 27, 3, 1, CAST(70000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (18, 28, 3, 1, CAST(70000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (19, 28, 2, 2, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (20, 29, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (21, 29, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (22, 30, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (23, 30, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (24, 31, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (25, 31, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (26, 32, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (27, 32, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (28, 32, 12, 1, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (29, 33, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (30, 33, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (31, 33, 12, 1, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (32, 33, 13, 1, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (33, 34, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (34, 34, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (35, 34, 12, 1, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (36, 34, 13, 1, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (37, 35, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (38, 35, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (39, 35, 12, 1, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (40, 35, 13, 1, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (41, 36, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (42, 36, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (43, 36, 12, 1, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (44, 36, 13, 1, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (45, 37, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (46, 37, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (47, 37, 12, 1, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (48, 37, 13, 1, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (49, 38, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (50, 38, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (51, 38, 12, 1, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (52, 38, 13, 1, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (53, 39, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (54, 39, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (55, 39, 12, 1, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (56, 39, 13, 1, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (57, 40, 3, 1, CAST(70000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (58, 40, 2, 2, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (59, 41, 2, 1, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (60, 41, 12, 1, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (61, 42, 13, 1, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (62, 43, 16, 1, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (63, 43, 2, 1, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (64, 44, 14, 3, CAST(1000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (65, 45, 2, 3, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (66, 45, 11, 1, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (67, 45, 15, 2, CAST(200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (68, 45, 3, 1, CAST(70000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (69, 45, 4, 1, CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (70, 46, 15, 1, CAST(200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[orderdetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (71, 46, 14, 1, CAST(1000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[orderdetails] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (1, 1, CAST(N'2026-06-20T18:20:25.2466491' AS DateTime2), CAST(160000.00 AS Decimal(18, 2)), N'Delivered')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (2, 1, CAST(N'2026-06-20T18:23:42.4590522' AS DateTime2), CAST(160000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (4, 1, CAST(N'2026-06-20T22:05:57.4120350' AS DateTime2), CAST(160000.00 AS Decimal(18, 2)), N'Placed')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (5, 0, CAST(N'2026-06-21T18:10:52.0759657' AS DateTime2), CAST(220000.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (6, 0, CAST(N'2026-06-21T19:09:30.0602606' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (7, 0, CAST(N'2026-06-21T19:10:12.6351835' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (8, 0, CAST(N'2026-06-21T19:15:26.6048573' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (9, 0, CAST(N'2026-06-21T21:58:05.2100977' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (10, 0, CAST(N'2026-06-21T22:00:46.4431755' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (11, 0, CAST(N'2026-06-21T22:01:35.3235593' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (12, 0, CAST(N'2026-06-21T22:05:15.8332830' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (13, 0, CAST(N'2026-06-21T22:08:56.4560743' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (14, 0, CAST(N'2026-06-21T22:09:18.0081486' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (15, 0, CAST(N'2026-06-21T22:09:41.1517626' AS DateTime2), CAST(0.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (16, 1, CAST(N'2026-06-21T22:20:17.9772085' AS DateTime2), CAST(240000.00 AS Decimal(18, 2)), N'Shipped')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (17, 1, CAST(N'2026-06-22T11:22:54.7089353' AS DateTime2), CAST(80000.00 AS Decimal(18, 2)), N'Placed')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (18, 1, CAST(N'2026-06-22T11:30:50.3573832' AS DateTime2), CAST(120000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (19, 1, CAST(N'2026-06-22T11:36:57.6121390' AS DateTime2), CAST(80000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (20, 1, CAST(N'2026-06-22T11:46:06.7530709' AS DateTime2), CAST(60000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (21, 1, CAST(N'2026-06-22T11:54:52.4878071' AS DateTime2), CAST(60000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (22, 1, CAST(N'2026-06-22T11:55:10.3465994' AS DateTime2), CAST(80000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (23, 2, CAST(N'2026-06-22T19:07:41.9315159' AS DateTime2), CAST(320000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (24, 2, CAST(N'2026-06-22T19:08:43.9275291' AS DateTime2), CAST(390000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (25, 2, CAST(N'2026-06-22T21:09:18.2304697' AS DateTime2), CAST(390000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (26, 2, CAST(N'2026-06-22T21:55:36.3148581' AS DateTime2), CAST(390000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (27, 2, CAST(N'2026-06-22T22:00:16.9848542' AS DateTime2), CAST(70000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (28, 2, CAST(N'2026-06-23T18:08:41.1301132' AS DateTime2), CAST(230000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (29, 3, CAST(N'2026-06-24T08:57:40.5648030' AS DateTime2), CAST(150000.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (30, 3, CAST(N'2026-06-24T12:29:07.7549126' AS DateTime2), CAST(150000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (31, 3, CAST(N'2026-06-24T12:31:49.7490004' AS DateTime2), CAST(150000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (32, 3, CAST(N'2026-06-24T13:00:34.3212303' AS DateTime2), CAST(151500.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (33, 3, CAST(N'2026-06-24T13:10:00.5835951' AS DateTime2), CAST(153500.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (34, 3, CAST(N'2026-06-24T15:28:23.1805742' AS DateTime2), CAST(153500.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (35, 3, CAST(N'2026-06-24T15:32:02.9658284' AS DateTime2), CAST(153500.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (36, 3, CAST(N'2026-06-24T15:32:39.6045758' AS DateTime2), CAST(153500.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (37, 3, CAST(N'2026-06-24T15:38:29.1880755' AS DateTime2), CAST(153500.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (38, 3, CAST(N'2026-06-24T15:44:06.0943493' AS DateTime2), CAST(153500.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (39, 3, CAST(N'2026-06-24T15:50:13.0790366' AS DateTime2), CAST(153500.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (40, 2, CAST(N'2026-06-24T19:40:04.2788305' AS DateTime2), CAST(230000.00 AS Decimal(18, 2)), N'Delivered')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (41, 7, CAST(N'2026-06-25T17:20:17.9028051' AS DateTime2), CAST(81500.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (42, 3, CAST(N'2026-06-25T19:58:45.6172831' AS DateTime2), CAST(2000.00 AS Decimal(18, 2)), N'Cancelled')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (43, 8, CAST(N'2026-06-26T08:36:49.5215183' AS DateTime2), CAST(80500.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (44, 2, CAST(N'2026-06-27T12:30:32.5471551' AS DateTime2), CAST(3000.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (45, 2, CAST(N'2026-06-27T15:59:48.6851942' AS DateTime2), CAST(490400.00 AS Decimal(18, 2)), N'Pending')
GO
INSERT [dbo].[orders] ([OrderID], [UserID], [OrderDate], [TotalAmount], [Status]) VALUES (46, 2, CAST(N'2026-06-27T16:09:19.8395871' AS DateTime2), CAST(1200.00 AS Decimal(18, 2)), N'Pending')
GO
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[payments] ON 
GO
INSERT [dbo].[payments] ([PaymentID], [OrderID], [PaymentMethod], [PaymentDate], [Amount], [PaymentStatus]) VALUES (1, 2, N'Cash', CAST(N'2026-06-20T18:23:42.6252260' AS DateTime2), CAST(160000.00 AS Decimal(18, 2)), N'Refunded')
GO
INSERT [dbo].[payments] ([PaymentID], [OrderID], [PaymentMethod], [PaymentDate], [Amount], [PaymentStatus]) VALUES (2, 4, N'UPI', CAST(N'2026-06-20T22:05:57.4602407' AS DateTime2), CAST(160000.00 AS Decimal(18, 2)), N'Paid')
GO
SET IDENTITY_INSERT [dbo].[payments] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 
GO
INSERT [dbo].[products] ([ProductID], [ProductName], [Price], [Stock], [ProductImagePath], [CategoryID]) VALUES (2, N'iPhone 15', CAST(90000.00 AS Decimal(18, 2)), 82, N'ProductImages/1a2ab9b5-2008-4442-abe4-81c1d23509a4.jpeg', 1)
GO
INSERT [dbo].[products] ([ProductID], [ProductName], [Price], [Stock], [ProductImagePath], [CategoryID]) VALUES (3, N'Samsung Galaxy S24', CAST(70000.00 AS Decimal(18, 2)), 6, N'ProductImages/95876672-9314-4908-a888-7349c1ce16e5.avif', 1)
GO
INSERT [dbo].[products] ([ProductID], [ProductName], [Price], [Stock], [ProductImagePath], [CategoryID]) VALUES (4, N'OnePlus 12', CAST(60000.00 AS Decimal(18, 2)), 11, N'ProductImages/16bd3117-a443-46dd-94dc-982665f46462.webp', 1)
GO
INSERT [dbo].[products] ([ProductID], [ProductName], [Price], [Stock], [ProductImagePath], [CategoryID]) VALUES (11, N'iPhone 16', CAST(90000.00 AS Decimal(18, 2)), 1, N'ProductImages/c7b553d8-f3e7-4111-9cb7-bf8c64034e8b.png', 1)
GO
INSERT [dbo].[products] ([ProductID], [ProductName], [Price], [Stock], [ProductImagePath], [CategoryID]) VALUES (12, N'OnePlus Earbuds ', CAST(1500.00 AS Decimal(18, 2)), 97, N'ProductImages/1f86f7ed-2f4d-424c-9273-23b93b6ddf1b.jpg', 2)
GO
INSERT [dbo].[products] ([ProductID], [ProductName], [Price], [Stock], [ProductImagePath], [CategoryID]) VALUES (13, N'Realme Buds', CAST(2000.00 AS Decimal(18, 2)), 99, N'ProductImages/6f03527e-491d-43b1-b828-58ea4d926e2c.jpg', 1)
GO
INSERT [dbo].[products] ([ProductID], [ProductName], [Price], [Stock], [ProductImagePath], [CategoryID]) VALUES (14, N'keyboard', CAST(1000.00 AS Decimal(18, 2)), 21, N'ProductImages/5515d0c2-4083-444a-accb-ea4d38a3240a.jpg', 3)
GO
INSERT [dbo].[products] ([ProductID], [ProductName], [Price], [Stock], [ProductImagePath], [CategoryID]) VALUES (15, N'Mouse', CAST(200.00 AS Decimal(18, 2)), 47, N'ProductImages/e93e0ef6-2be6-4824-b342-501656b5435a.jpg', 3)
GO
INSERT [dbo].[products] ([ProductID], [ProductName], [Price], [Stock], [ProductImagePath], [CategoryID]) VALUES (16, N'Nokia mobile ', CAST(500.00 AS Decimal(18, 2)), 499, N'ProductImages/d5153913-e8d8-4ca7-b834-0fd4c18161d2.webp', 1)
GO
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (1, 2, 1, 4, N'good mobile')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (2, 2, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (3, 2, 1, 4, N'not bad
')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (4, 2, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (5, 2, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (6, 2, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (7, 2, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (8, 12, 1, 4, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (9, 12, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (10, 4, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (11, 4, 1, 4, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (12, 3, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (13, 3, 1, 3, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (14, 2, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (15, 2, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (16, 2, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (17, 2, 1, 3, N'not that good ')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (18, 2, 1, 5, N'')
GO
INSERT [dbo].[Reviews] ([ReviewID], [ProductID], [UserID], [Rating], [Comment]) VALUES (19, 2, 1, 5, N'')
GO
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'User')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [Name], [Email], [PasswordHash], [Phone], [Address], [CreatedDate], [RoleID]) VALUES (1, N'Imraan', N'imraan@gmail.com', N'kzb8gJgnNmAQxGzTftOIH0NRk9JWGiR5zRaUHVf7Hp0=', N'9876543210', N'Chennai', CAST(N'2026-06-19T14:30:45.5585252' AS DateTime2), 1)
GO
INSERT [dbo].[Users] ([UserID], [Name], [Email], [PasswordHash], [Phone], [Address], [CreatedDate], [RoleID]) VALUES (2, N'Admin', N'admin@gmail.com', N'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI=', N'9876543210', N'Chennai', CAST(N'2026-06-22T19:05:23.6368220' AS DateTime2), 1)
GO
INSERT [dbo].[Users] ([UserID], [Name], [Email], [PasswordHash], [Phone], [Address], [CreatedDate], [RoleID]) VALUES (3, N'imraan', N'user@gmail.com', N'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI=', N'9988776655', N'tamilnadu', CAST(N'2026-06-24T08:56:58.5633536' AS DateTime2), 2)
GO
INSERT [dbo].[Users] ([UserID], [Name], [Email], [PasswordHash], [Phone], [Address], [CreatedDate], [RoleID]) VALUES (4, N'user2', N'user2@gmail.com', N'SB9swFERQ8zdfi0bG5T68KcAqLSc0Tkipwta4orKqMU=', N'9988776677', N'tamilnadu', CAST(N'2026-06-25T16:09:01.7101584' AS DateTime2), 2)
GO
INSERT [dbo].[Users] ([UserID], [Name], [Email], [PasswordHash], [Phone], [Address], [CreatedDate], [RoleID]) VALUES (5, N'user4', N'user4@gmail.com', N'SB9swFERQ8zdfi0bG5T68KcAqLSc0Tkipwta4orKqMU=', N'9911002233', N'chennai', CAST(N'2026-06-25T16:22:00.0124730' AS DateTime2), 2)
GO
INSERT [dbo].[Users] ([UserID], [Name], [Email], [PasswordHash], [Phone], [Address], [CreatedDate], [RoleID]) VALUES (6, N'user5', N'user5@gmail.com', N'jZae727K08KaOmKSgOaGzww/XVqGr/PKEgIMkjrcbJI=', N'9900990099', N'tamilnadu', CAST(N'2026-06-25T16:26:04.0601443' AS DateTime2), 2)
GO
INSERT [dbo].[Users] ([UserID], [Name], [Email], [PasswordHash], [Phone], [Address], [CreatedDate], [RoleID]) VALUES (7, N'john', N'john@gmail.com', N'tLWXxxSo9JED2k2rAmavDuCuT4V1JQqEhVw9dpQc1CI=', N'9988770099', N'singapore', CAST(N'2026-06-25T17:19:01.1607838' AS DateTime2), 2)
GO
INSERT [dbo].[Users] ([UserID], [Name], [Email], [PasswordHash], [Phone], [Address], [CreatedDate], [RoleID]) VALUES (8, N'krishna', N'krishna@gmail.com', N'jk8w8OeC30KXwOuHV1YEcu7IKJfq6OsRFC7Tg+uiFYI=', N'9988770099', N'chennai', CAST(N'2026-06-26T08:24:02.4399344' AS DateTime2), 2)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_cartitems_CartID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE NONCLUSTERED INDEX [IX_cartitems_CartID] ON [dbo].[cartitems]
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_cartitems_ProductID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE NONCLUSTERED INDEX [IX_cartitems_ProductID] ON [dbo].[cartitems]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_carts_UserID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_carts_UserID] ON [dbo].[carts]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_orderdetails_OrderID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE NONCLUSTERED INDEX [IX_orderdetails_OrderID] ON [dbo].[orderdetails]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_orderdetails_ProductID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE NONCLUSTERED INDEX [IX_orderdetails_ProductID] ON [dbo].[orderdetails]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_payments_OrderID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE NONCLUSTERED INDEX [IX_payments_OrderID] ON [dbo].[payments]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_products_CategoryID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE NONCLUSTERED INDEX [IX_products_CategoryID] ON [dbo].[products]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reviews_ProductID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE NONCLUSTERED INDEX [IX_Reviews_ProductID] ON [dbo].[Reviews]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reviews_UserID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE NONCLUSTERED INDEX [IX_Reviews_UserID] ON [dbo].[Reviews]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_RoleID]    Script Date: 03-07-2026 19:23:09 ******/
CREATE NONCLUSTERED INDEX [IX_Users_RoleID] ON [dbo].[Users]
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
ALTER TABLE [dbo].[carts]  WITH CHECK ADD  CONSTRAINT [FK_carts_Users_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[carts] CHECK CONSTRAINT [FK_carts_Users_UserID]
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
ALTER TABLE [dbo].[payments]  WITH CHECK ADD  CONSTRAINT [FK_payments_orders_OrderID] FOREIGN KEY([OrderID])
REFERENCES [dbo].[orders] ([OrderID])
GO
ALTER TABLE [dbo].[payments] CHECK CONSTRAINT [FK_payments_orders_OrderID]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_categories_CategoryID] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[categories] ([CategoryID])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_products_categories_CategoryID]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_products_ProductID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[products] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_products_ProductID]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Users_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Users_UserID]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles_RoleID] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles_RoleID]
GO
/****** Object:  StoredProcedure [dbo].[GetAllTables]    Script Date: 03-07-2026 19:23:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllTables]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TABLE_NAME
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_TYPE = 'BASE TABLE'
      AND TABLE_SCHEMA = 'dbo'
    ORDER BY TABLE_NAME;
END
GO
USE [master]
GO
ALTER DATABASE [EcommerceDB] SET  READ_WRITE 
GO
