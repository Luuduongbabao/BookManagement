USE [BookMGN]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [char](5) NOT NULL,
	[AdminName] [nvarchar](100) NOT NULL,
	[AdminEmail] [nvarchar](100) NOT NULL,
	[AdminAddress] [text] NOT NULL,
	[AdminPhone] [varchar](20) NOT NULL,
	[AdminPassword] [varchar](255) NOT NULL,
	[AdminDOB] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[BookID] [char](5) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[author] [nvarchar](100) NULL,
	[publisher] [nvarchar](100) NULL,
	[price] [decimal](10, 2) NOT NULL,
	[stock] [int] NOT NULL,
	[CategoryID] [char](5) NULL,
	[Book_Image] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookSupplies]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookSupplies](
	[Supply_id] [char](5) NOT NULL,
	[supplier_id] [char](5) NOT NULL,
	[book_id] [char](5) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[DateSuppliers] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Supply_id] ASC,
	[supplier_id] ASC,
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cashier]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cashier](
	[CashierID] [char](5) NOT NULL,
	[CashierName] [nvarchar](100) NOT NULL,
	[CashierEmail] [nvarchar](100) NOT NULL,
	[CashierAddress] [text] NOT NULL,
	[CashierPhone] [varchar](20) NOT NULL,
	[CashierPassword] [varchar](255) NOT NULL,
	[CashierDOB] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CashierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [char](5) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CusID] [char](5) NOT NULL,
	[CusName] [nvarchar](100) NOT NULL,
	[CusEmail] [nvarchar](100) NOT NULL,
	[CusAddress] [text] NOT NULL,
	[CusPhone] [varchar](20) NOT NULL,
	[CusPassword] [nvarchar](255) NOT NULL,
	[CusDob] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderBooks]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderBooks](
	[OrderID] [char](5) NOT NULL,
	[BookID] [char](5) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[DetailTotalPrice]  AS ([quantity]*[price]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderProducts]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProducts](
	[OrderID] [char](5) NOT NULL,
	[ProductID] [char](5) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[DetailTotalPrice]  AS ([quantity]*[price]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [char](5) NOT NULL,
	[CusID] [char](5) NOT NULL,
	[status] [varchar](20) NULL,
	[payment_method] [varchar](20) NOT NULL,
	[ShippingAddress] [nvarchar](255) NOT NULL,
	[OrderDate] [date] NULL,
	[TotalOrderPrice] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [char](5) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductPrice] [decimal](10, 2) NOT NULL,
	[ProductStock] [int] NOT NULL,
	[Product_Image] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSupplies]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSupplies](
	[Supply_id] [char](5) NOT NULL,
	[Supplier_id] [char](5) NOT NULL,
	[productID] [char](5) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[DateSuppliers] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Supply_id] ASC,
	[Supplier_id] ASC,
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[supplier_id] [char](5) NOT NULL,
	[supplier_name] [nvarchar](100) NOT NULL,
	[supplier_email] [nvarchar](100) NOT NULL,
	[phone] [varchar](20) NULL,
	[address] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 3/31/2025 10:18:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[transaction_id] [char](5) NOT NULL,
	[Order_ID] [char](5) NOT NULL,
	[cashier_id] [char](5) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[payment_method] [varchar](20) NOT NULL,
	[TransactionDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Admin] ([AdminID], [AdminName], [AdminEmail], [AdminAddress], [AdminPhone], [AdminPassword], [AdminDOB]) VALUES (N'AD001', N'Pham Thi E', N'e@gmail.com', N'Nha Trang', N'0944556677', N'111111', CAST(N'1985-12-25' AS Date))
INSERT [dbo].[Admin] ([AdminID], [AdminName], [AdminEmail], [AdminAddress], [AdminPhone], [AdminPassword], [AdminDOB]) VALUES (N'AD002', N'Nguyen Thi F', N'f@example.com', N'Da Lat', N'0966778899', N'222222', CAST(N'1992-07-07' AS Date))
GO
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B001 ', N'The Great Adventure', N'Author A', N'Publisher X', CAST(80000.00 AS Decimal(10, 2)), 66, N'CT001', N'/Images/B001.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B0010', N'Feel Good Food: Over 100 Healthy Family Recipes', N'Joe Wicks', N'HQ', CAST(442500.00 AS Decimal(10, 2)), 1, N'CT004', N'/Images/B0010.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B0011', N'Code Dependent', N'Madhumita Murgia', N'Pan Macmillan', CAST(269250.00 AS Decimal(10, 2)), 25, N'CT006', N'/Images/B0011.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B0012', N'100 Facts Inventions', N'Duncan Brewer', N'Miles Kelly Publishing', CAST(73000.00 AS Decimal(10, 2)), 1, N'CT006', N'/Images/B0012.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B0013', N'Children''s Book Of Art', N'Rosie Dickins, Uwe Mayer', N'Usborne Publishing', CAST(303300.00 AS Decimal(10, 2)), 15, N'CT007', N'/Images/B0013.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B0014', N'Inspiring Rock Designs', N'Igloo Books', N'Bonnier Books Ltd', CAST(139500.00 AS Decimal(10, 2)), 85, N'CT007', N'/Images/B0014.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B002 ', N'Physics for Everyone', N'Author B', N'Publisher Y', CAST(200000.00 AS Decimal(10, 2)), 45, N'CT002', N'/Images/B002.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B0025', N'DK Art - Bách Khoa Toàn Thư Về Nghệ Thuật - Những Phân Tích Thú Vị Về Nghệ Thuật Và Hội Họa', N'DK', N'Dân Trí', CAST(399200.00 AS Decimal(10, 2)), 7, N'CT007', N'/Images/B0025.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B003 ', N'Đắc Nhân Tâm', N'Dale Carnegie', N'Nhà xuất bản Trẻ', CAST(100000.00 AS Decimal(10, 2)), 50, N'CT001', N'/Images/DacNhanTam.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B0030', N'Đàn Ông Sao Hỏa, Đàn Bà Sao Kim', N'John Gray', N'Hồng Đức ', CAST(122200.00 AS Decimal(10, 2)), 109, N'CT003', N'/Images/B0030.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B004 ', N'Harry Potter', N'J.K. Rowling', N'Bloomsbury ', CAST(112000.00 AS Decimal(10, 2)), 80, N'CT001', N'/Images/harry potter.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B006 ', N'The Fellowship Of The Ring', N'J.R.R. Tolkien', N'George Allen & Unwin', CAST(209300.00 AS Decimal(10, 2)), 100, N'CT001', N'/Images/B006.png')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B007 ', N'The Origin Of Species', N'Charles Darwin''s', N'John Murray', CAST(143000.00 AS Decimal(10, 2)), 120, N'CT002', N'/Images/B007.png')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B008 ', N'Lược Sử Vạn Vật (Tái Bản 2018)', N'Bill Bryson', N'NXB Khoa Học Xã Hội', CAST(245000.00 AS Decimal(10, 2)), 100, N'CT002', N'/Images/B008.png')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B009 ', N'Cooking With Superfoods', N'Hannah Frey', N'H.F.Ullmann', CAST(315000.00 AS Decimal(10, 2)), 50, N'CT004', N'/Images/B009.jpg')
INSERT [dbo].[Book] ([BookID], [title], [author], [publisher], [price], [stock], [CategoryID], [Book_Image]) VALUES (N'B012 ', N'Sáu người đi khắp thế gian (The Drifters) - Tập 1', N'James A Michener', N'NXB Văn Học', CAST(95000.00 AS Decimal(10, 2)), 13, N'CT005', N'/Images/B012.jpg')
GO
INSERT [dbo].[BookSupplies] ([Supply_id], [supplier_id], [book_id], [quantity], [price], [DateSuppliers]) VALUES (N'BS001', N'S001 ', N'B001 ', 20, CAST(75000.00 AS Decimal(10, 2)), CAST(N'2025-03-28T21:18:29.680' AS DateTime))
INSERT [dbo].[BookSupplies] ([Supply_id], [supplier_id], [book_id], [quantity], [price], [DateSuppliers]) VALUES (N'BS002', N'S002 ', N'B002 ', 15, CAST(180000.00 AS Decimal(10, 2)), CAST(N'2025-03-28T21:18:29.680' AS DateTime))
INSERT [dbo].[BookSupplies] ([Supply_id], [supplier_id], [book_id], [quantity], [price], [DateSuppliers]) VALUES (N'BS003', N'S003 ', N'B007 ', 50, CAST(150000.00 AS Decimal(10, 2)), CAST(N'2025-03-29T09:45:12.000' AS DateTime))
INSERT [dbo].[BookSupplies] ([Supply_id], [supplier_id], [book_id], [quantity], [price], [DateSuppliers]) VALUES (N'BS004', N'S003 ', N'B006 ', 100, CAST(230000.00 AS Decimal(10, 2)), CAST(N'2025-03-29T10:14:20.000' AS DateTime))
INSERT [dbo].[BookSupplies] ([Supply_id], [supplier_id], [book_id], [quantity], [price], [DateSuppliers]) VALUES (N'BS005', N'S004 ', N'B009 ', 50, CAST(315000.00 AS Decimal(10, 2)), CAST(N'2025-03-29T12:00:32.000' AS DateTime))
INSERT [dbo].[BookSupplies] ([Supply_id], [supplier_id], [book_id], [quantity], [price], [DateSuppliers]) VALUES (N'BS006', N'S005 ', N'B0013', 10, CAST(303300.00 AS Decimal(10, 2)), CAST(N'2025-03-29T12:50:31.000' AS DateTime))
INSERT [dbo].[BookSupplies] ([Supply_id], [supplier_id], [book_id], [quantity], [price], [DateSuppliers]) VALUES (N'BS009', N'S006 ', N'B0030', 100, CAST(122200.00 AS Decimal(10, 2)), CAST(N'2025-03-29T13:04:34.000' AS DateTime))
GO
INSERT [dbo].[Cashier] ([CashierID], [CashierName], [CashierEmail], [CashierAddress], [CashierPhone], [CashierPassword], [CashierDOB]) VALUES (N'CA001', N'Le Van C', N'c@gmail.com', N'HCM City', N'09090909', N'12345', CAST(N'1999-05-20' AS Date))
INSERT [dbo].[Cashier] ([CashierID], [CashierName], [CashierEmail], [CashierAddress], [CashierPhone], [CashierPassword], [CashierDOB]) VALUES (N'CA002', N'Hoang Thi D', N'd@gmail.com', N'Ha Noi', N'08080808', N'45678', CAST(N'1995-05-05' AS Date))
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (N'CT007', N'Art')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (N'CT004', N'Cookbooks')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (N'CT001', N'Fiction')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (N'CT003', N'Romance')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (N'CT002', N'Science')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (N'CT006', N'Technology')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (N'CT005', N'Travel')
GO
INSERT [dbo].[Customer] ([CusID], [CusName], [CusEmail], [CusAddress], [CusPhone], [CusPassword], [CusDob]) VALUES (N'07ba6', N'Hoàng Bách', N'hb1@gmail.com', N'VN', N'0937467641', N'hoangbach', CAST(N'2004-06-25' AS Date))
INSERT [dbo].[Customer] ([CusID], [CusName], [CusEmail], [CusAddress], [CusPhone], [CusPassword], [CusDob]) VALUES (N'192a5', N'Hoang Bach', N'hb@gmail.com', N'VietNam', N'0984753475', N'114b5d7acf4bb10237f65f59c1ae1bd01ce8831524b545d5a437bcc13accf4b3', CAST(N'2003-06-25' AS Date))
INSERT [dbo].[Customer] ([CusID], [CusName], [CusEmail], [CusAddress], [CusPhone], [CusPassword], [CusDob]) VALUES (N'5d25d', N'AD', N'ad@gmail.com', N'VietNam', N'0947279205', N'ad@123', CAST(N'2004-07-09' AS Date))
INSERT [dbo].[Customer] ([CusID], [CusName], [CusEmail], [CusAddress], [CusPhone], [CusPassword], [CusDob]) VALUES (N'a1c0b', N'Hoàng Vy', N'hv@gmail.com', N'Bình Th?nh', N'0947163926', N'hoangvy', CAST(N'2004-11-30' AS Date))
INSERT [dbo].[Customer] ([CusID], [CusName], [CusEmail], [CusAddress], [CusPhone], [CusPassword], [CusDob]) VALUES (N'C001 ', N'Nguyen Van A', N'a@gmail.com', N'123 ABC Street', N'0123456789', N'password12345', CAST(N'2000-01-01' AS Date))
INSERT [dbo].[Customer] ([CusID], [CusName], [CusEmail], [CusAddress], [CusPhone], [CusPassword], [CusDob]) VALUES (N'C002 ', N'Tran Thi B', N'b@example.com', N'456 XYZ City', N'0987654321', N'password56789', CAST(N'2006-07-02' AS Date))
GO
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O001 ', N'B001 ', 2, CAST(80000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O002 ', N'B002 ', 1, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O3701', N'B001 ', 1, CAST(80000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O4176', N'B003 ', 1, CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O4263', N'B001 ', 1, CAST(80000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O4700', N'B006 ', 1, CAST(209300.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O5176', N'B006 ', 1, CAST(209300.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O5576', N'B001 ', 1, CAST(80000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O6274', N'B009 ', 1, CAST(315000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O6480', N'B004 ', 1, CAST(112000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O6480', N'B008 ', 1, CAST(245000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O7287', N'B001 ', 1, CAST(80000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O8232', N'B001 ', 1, CAST(80000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O8232', N'B007 ', 1, CAST(143000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O8464', N'B001 ', 1, CAST(80000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O8637', N'B006 ', 1, CAST(209300.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O8975', N'B006 ', 1, CAST(209300.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O9159', N'B006 ', 1, CAST(209300.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O9632', N'B006 ', 1, CAST(209300.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O9643', N'B001 ', 1, CAST(80000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderBooks] ([OrderID], [BookID], [quantity], [price]) VALUES (N'O9643', N'B0030', 1, CAST(122200.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O001 ', N'P001 ', 3, CAST(50000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O002 ', N'P002 ', 5, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O1894', N'P006 ', 1, CAST(90000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O2115', N'P007 ', 1, CAST(82000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O3208', N'P002 ', 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O3208', N'P003 ', 1, CAST(10000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O3701', N'P0011', 1, CAST(14025.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O4088', N'P006 ', 1, CAST(90000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O5576', N'P005 ', 1, CAST(400000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O7287', N'P0010', 1, CAST(36975.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O8232', N'P004 ', 1, CAST(250000.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O8464', N'P0011', 1, CAST(14025.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O9643', N'P0010', 1, CAST(36975.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderProducts] ([OrderID], [ProductID], [quantity], [price]) VALUES (N'O9643', N'P008 ', 1, CAST(128100.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O001 ', N'C001 ', N'Completed', N'Cash', N'123 ABC Street', CAST(N'2025-03-28' AS Date), CAST(310000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O002 ', N'C002 ', N'Completed', N'Credit Card', N'456 XYZ City', CAST(N'2025-03-28' AS Date), CAST(225000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O1894', N'C002 ', N'Completed', N'Online Banking', N'Tiền Giang', CAST(N'2025-03-29' AS Date), CAST(90000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O2115', N'C001 ', N'Completed', N'Cash', N'Long An', CAST(N'2025-03-29' AS Date), CAST(82000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O3208', N'07ba6', N'Completed', N'Online Banking', N'12 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(15000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O3701', N'5d25d', N'Completed', N'Credit Card', N'6 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(94025.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O3815', N'07ba6', N'Completed', N'Cash', N'12 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(627900.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O4088', N'C002 ', N'Cancelled', N'Credit Card', N'Tiền Giang', CAST(N'2025-03-29' AS Date), CAST(90000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O4176', N'5d25d', N'Completed', N'Cash', N'Binh Thanh', CAST(N'2025-03-29' AS Date), CAST(100000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O4263', N'5d25d', N'Completed', N'Cash', N'123 Dien Bien Phu', CAST(N'2025-03-29' AS Date), CAST(80000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O4700', N'a1c0b', N'Cancelled', N'Online Banking', N'6 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(209300.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O5176', N'07ba6', N'Pending', N'Cash', N'6 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(209300.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O5576', N'5d25d', N'Completed', N'Credit Card', N'Binh Thanh', CAST(N'2025-03-29' AS Date), CAST(480000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O6274', N'a1c0b', N'Pending', N'Cash', N'6 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(315000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O6480', N'07ba6', N'Completed', N'Credit Card', N'12 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(357000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O6836', N'07ba6', N'Pending', N'Cash', N'6 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(418600.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O7287', N'5d25d', N'Pending', N'Credit Card', N'6 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(116975.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O8232', N'a1c0b', N'Cancelled', N'Online Banking', N'6 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(473000.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O8464', N'5d25d', N'Pending', N'Online Banking', N'123 Dien Bien Phu', CAST(N'2025-03-29' AS Date), CAST(94025.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O8637', N'5d25d', N'Pending', N'Online Banking', N'Binh Thanh', CAST(N'2025-03-29' AS Date), CAST(209300.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O8975', N'a1c0b', N'Pending', N'Online Banking', N'6 Xô Viết Nghệ Tĩnh', CAST(N'2025-03-29' AS Date), CAST(209300.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O9159', N'C001 ', N'Pending', N'Credit Card', N'Long An', CAST(N'2025-03-29' AS Date), CAST(209300.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O9632', N'C001 ', N'Pending', N'Online Banking', N'123 Dien Bien Phu', CAST(N'2025-03-29' AS Date), CAST(209300.00 AS Decimal(18, 2)))
INSERT [dbo].[Orders] ([OrderID], [CusID], [status], [payment_method], [ShippingAddress], [OrderDate], [TotalOrderPrice]) VALUES (N'O9643', N'5d25d', N'Pending', N'Credit Card', N'Binh Thanh', CAST(N'2025-03-30' AS Date), CAST(367275.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P001 ', N'Calculator', CAST(50000.00 AS Decimal(10, 2)), 150, N'~/Images/CASIO.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P0010', N'Dạ Quang Swing Cool Stabilo - HLP275 - 116 - Màu Xanh Lá Phấn', CAST(36975.00 AS Decimal(10, 2)), 0, N'/Images/P0010.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P0011', N'Vở Study Typography - Kẻ Ngang 80 Trang', CAST(14025.00 AS Decimal(10, 2)), 198, N'/Images/P0011.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P002 ', N'Pen', CAST(5000.00 AS Decimal(10, 2)), 300, N'~/Images/P002.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P003 ', N'Student ID Card Lanyard', CAST(10000.00 AS Decimal(10, 2)), 100, N'/Images/P003.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P004 ', N'LocknLock Thermal Bottle 800ml', CAST(250000.00 AS Decimal(10, 2)), 60, N'/Images/P004.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P005 ', N'Premium Water-Based Colored Pencils Finenolo Deli', CAST(400000.00 AS Decimal(10, 2)), 30, N'/Images/P005.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P006 ', N'Pin AA Energizer Max E91BP4+2', CAST(90000.00 AS Decimal(10, 2)), 20, N'/Images/P006.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P007 ', N'Khay Bút Đa Năng', CAST(82000.00 AS Decimal(10, 2)), 10, N'/Images/P007.png')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P008 ', N'Túi Đựng Hộp Cơm Giữ Nhiệt - WanLongDa', CAST(128100.00 AS Decimal(10, 2)), 24, N'/Images/P008.jpg')
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductPrice], [ProductStock], [Product_Image]) VALUES (N'P009 ', N'hước Đo Độ Strive 180 - Thiên Long ST-035', CAST(4050.00 AS Decimal(10, 2)), 100, N'/Images/P009.jpg')
GO
INSERT [dbo].[ProductSupplies] ([Supply_id], [Supplier_id], [productID], [quantity], [price], [DateSuppliers]) VALUES (N'PS001', N'S001 ', N'P001 ', 50, CAST(45000.00 AS Decimal(10, 2)), CAST(N'2025-03-28T21:18:29.687' AS DateTime))
INSERT [dbo].[ProductSupplies] ([Supply_id], [Supplier_id], [productID], [quantity], [price], [DateSuppliers]) VALUES (N'PS002', N'S002 ', N'P002 ', 100, CAST(4000.00 AS Decimal(10, 2)), CAST(N'2025-03-28T21:18:29.687' AS DateTime))
INSERT [dbo].[ProductSupplies] ([Supply_id], [Supplier_id], [productID], [quantity], [price], [DateSuppliers]) VALUES (N'S0003', N'S002 ', N'P006 ', 20, CAST(90000.00 AS Decimal(10, 2)), CAST(N'2025-03-29T00:00:00.000' AS DateTime))
INSERT [dbo].[ProductSupplies] ([Supply_id], [Supplier_id], [productID], [quantity], [price], [DateSuppliers]) VALUES (N'S0004', N'S003 ', N'P007 ', 10, CAST(82000.00 AS Decimal(10, 2)), CAST(N'2025-03-29T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [supplier_email], [phone], [address]) VALUES (N'S001 ', N'Supplier 1', N'supplier1@gmail.com', N'888888', N'72 Vung Tau')
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [supplier_email], [phone], [address]) VALUES (N'S002 ', N'Supplier 2', N'supplier2z@gmail.com', N'09272727', N'62 Long An')
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [supplier_email], [phone], [address]) VALUES (N'S003 ', N'Nhà Sách Tân Phú', N'contact@tansach.com', N'02866554433', N'TP.HCM')
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [supplier_email], [phone], [address]) VALUES (N'S004 ', N'Cty Sách Á Châu', N'info@achaubooks.vn', N'0916 640 166', N'TP.HCM')
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [supplier_email], [phone], [address]) VALUES (N'S005 ', N'Thebookland', N'info.thebookland@gmail.com', N'0936-749-847', N'Da Nang')
INSERT [dbo].[Suppliers] ([supplier_id], [supplier_name], [supplier_email], [phone], [address]) VALUES (N'S006 ', N'MCBooks', N'contact@mcbooks.vn', N' 0901 385 589', N'HN')
GO
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T001 ', N'O001 ', N'CA001', CAST(250000.00 AS Decimal(10, 2)), N'Cash', CAST(N'2025-03-28T21:18:29.680' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T002 ', N'O002 ', N'CA002', CAST(100000.00 AS Decimal(10, 2)), N'Credit Card', CAST(N'2025-03-28T21:18:29.680' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T1721', N'O4263', N'CA001', CAST(80000.00 AS Decimal(10, 2)), N'Cash', CAST(N'2025-03-29T07:19:49.257' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T3034', N'O5576', N'CA001', CAST(480000.00 AS Decimal(10, 2)), N'Credit Card', CAST(N'2025-03-29T07:23:22.313' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T3389', N'O9159', N'CA001', CAST(209300.00 AS Decimal(10, 2)), N'Credit Card', CAST(N'2025-03-29T09:42:03.520' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T3871', N'O2115', N'CA001', CAST(82000.00 AS Decimal(10, 2)), N'Cash', CAST(N'2025-03-29T10:52:13.227' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T4746', N'O7287', N'CA001', CAST(116975.00 AS Decimal(10, 2)), N'Credit Card', CAST(N'2025-03-29T14:51:18.490' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T4965', N'O3208', N'CA001', CAST(15000.00 AS Decimal(10, 2)), N'Online Banking', CAST(N'2025-03-29T08:06:13.040' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T5008', N'O6480', N'CA001', CAST(357000.00 AS Decimal(10, 2)), N'Credit Card', CAST(N'2025-03-29T07:57:51.977' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T5629', N'O9643', N'CA001', CAST(367275.00 AS Decimal(10, 2)), N'Credit Card', CAST(N'2025-03-30T16:57:27.567' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T5690', N'O8232', N'CA001', CAST(473000.00 AS Decimal(10, 2)), N'Online Banking', CAST(N'2025-03-29T09:12:14.330' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T6095', N'O8637', N'CA001', CAST(209300.00 AS Decimal(10, 2)), N'Online Banking', CAST(N'2025-03-29T09:30:22.477' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T6274', N'O6274', N'CA001', CAST(315000.00 AS Decimal(10, 2)), N'Cash', CAST(N'2025-03-29T12:01:56.990' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T7317', N'O4088', N'CA001', CAST(90000.00 AS Decimal(10, 2)), N'Credit Card', CAST(N'2025-03-29T10:33:16.487' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T7405', N'O4176', N'CA001', CAST(100000.00 AS Decimal(10, 2)), N'Cash', CAST(N'2025-03-29T08:31:14.727' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T7503', N'O8975', N'CA001', CAST(209300.00 AS Decimal(10, 2)), N'Online Banking', CAST(N'2025-03-29T09:13:12.220' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T7929', N'O4700', N'CA001', CAST(209300.00 AS Decimal(10, 2)), N'Online Banking', CAST(N'2025-03-29T09:22:34.393' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T7963', N'O8464', N'CA001', CAST(94025.00 AS Decimal(10, 2)), N'Online Banking', CAST(N'2025-03-29T14:44:48.250' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T8352', N'O1894', N'CA001', CAST(90000.00 AS Decimal(10, 2)), N'Online Banking', CAST(N'2025-03-29T10:45:17.903' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T8405', N'O5176', N'CA001', CAST(209300.00 AS Decimal(10, 2)), N'Cash', CAST(N'2025-03-29T09:29:31.270' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T9632', N'O9632', N'CA001', CAST(209300.00 AS Decimal(10, 2)), N'Online Banking', CAST(N'2025-03-29T09:30:49.843' AS DateTime))
INSERT [dbo].[Transactions] ([transaction_id], [Order_ID], [cashier_id], [amount], [payment_method], [TransactionDate]) VALUES (N'T9942', N'O3701', N'CA001', CAST(94025.00 AS Decimal(10, 2)), N'Credit Card', CAST(N'2025-03-29T22:42:17.000' AS DateTime))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Admin__F2AA7AD94C93CE83]    Script Date: 3/31/2025 10:18:54 AM ******/
ALTER TABLE [dbo].[Admin] ADD UNIQUE NONCLUSTERED 
(
	[AdminEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Cashier__C6A5D8303CC34582]    Script Date: 3/31/2025 10:18:54 AM ******/
ALTER TABLE [dbo].[Cashier] ADD UNIQUE NONCLUSTERED 
(
	[CashierEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__8517B2E03F5CCA96]    Script Date: 3/31/2025 10:18:54 AM ******/
ALTER TABLE [dbo].[Categories] ADD UNIQUE NONCLUSTERED 
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__60A7203FDC532446]    Script Date: 3/31/2025 10:18:54 AM ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[CusEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Book] ADD  DEFAULT ((0)) FOR [stock]
GO
ALTER TABLE [dbo].[BookSupplies] ADD  DEFAULT (getdate()) FOR [DateSuppliers]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [status]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [TotalOrderPrice]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [ProductStock]
GO
ALTER TABLE [dbo].[ProductSupplies] ADD  DEFAULT (getdate()) FOR [DateSuppliers]
GO
ALTER TABLE [dbo].[Transactions] ADD  DEFAULT (getdate()) FOR [TransactionDate]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[BookSupplies]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[BookSupplies]  WITH CHECK ADD FOREIGN KEY([supplier_id])
REFERENCES [dbo].[Suppliers] ([supplier_id])
GO
ALTER TABLE [dbo].[OrderBooks]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[OrderBooks]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderProducts]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderProducts]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CusID])
REFERENCES [dbo].[Customer] ([CusID])
GO
ALTER TABLE [dbo].[ProductSupplies]  WITH CHECK ADD FOREIGN KEY([productID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductSupplies]  WITH CHECK ADD FOREIGN KEY([Supplier_id])
REFERENCES [dbo].[Suppliers] ([supplier_id])
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD FOREIGN KEY([cashier_id])
REFERENCES [dbo].[Cashier] ([CashierID])
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD FOREIGN KEY([Order_ID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[BookSupplies]  WITH CHECK ADD CHECK  (([price]>(0)))
GO
ALTER TABLE [dbo].[BookSupplies]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[OrderBooks]  WITH CHECK ADD CHECK  (([price]>(0)))
GO
ALTER TABLE [dbo].[OrderBooks]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[OrderProducts]  WITH CHECK ADD CHECK  (([price]>(0)))
GO
ALTER TABLE [dbo].[OrderProducts]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD CHECK  (([payment_method]='Online Banking' OR [payment_method]='Credit Card' OR [payment_method]='Cash'))
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD CHECK  (([status]='Cancelled' OR [status]='Completed' OR [status]='Pending'))
GO
ALTER TABLE [dbo].[ProductSupplies]  WITH CHECK ADD CHECK  (([price]>(0)))
GO
ALTER TABLE [dbo].[ProductSupplies]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD CHECK  (([payment_method]='Online Banking' OR [payment_method]='Credit Card' OR [payment_method]='Cash'))
GO
