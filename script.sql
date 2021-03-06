USE [Final project]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteCategory]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_DeleteCategory]
@id int,
@Error nvarchar(256) output
as
	Update Category set Status = 0 where CategoryId=@id
	--Lỗi sẽ xét ràng buộc sau
	set @Error=''

GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteCustomer]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_DeleteCustomer]
@id int,
@Error nvarchar(256) output
as
	Update Customer set Status = 0 where CustomerId=@id
	--Lỗi sẽ xét ràng buộc sau
	set @Error=''

GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteProducts]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_DeleteProducts]
@id int,
@Error nvarchar(256) output
as
	Update Products set Status = 0 where ProductId=@id
	--Lỗi sẽ xét ràng buộc sau
	set @Error=''

GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteProvider]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_DeleteProvider]
@id int,
@Error nvarchar(256) output
as
	Update Provider set Status = 0 where ProviderId=@id
	--Lỗi sẽ xét ràng buộc sau
	set @Error=''


GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteUserInfo]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_DeleteUserInfo]
@id int,
@Error nvarchar(256) output
as
	Update UserInfo set Status = 0 where UserId=@id
	--Lỗi sẽ xét ràng buộc sau
	set @Error=''


GO
/****** Object:  StoredProcedure [dbo].[usp_GetCategory]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_GetCategory]
as
	select * from Category where Status = 1
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCustomer]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_GetCustomer]
as
	select * from Customer where Status = 1

GO
/****** Object:  StoredProcedure [dbo].[usp_GetProductDetail]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_GetProductDetail] 
    @ProductId int 
AS   

    select p.ProductId,p.ProductName,p.IconImg,p.Screen,p.Battery,p.CPU,p.Ram,p.Camera,p.Color,p.Osystem,p.Description,p.Discount,p.PriceOut,i.ProviderName 
	from Products p inner join Provider i on p.ProviderId=i.ProviderId 
	where p.Status=1 and p.ProductId=@ProductId and i.Status=1 

GO
/****** Object:  StoredProcedure [dbo].[usp_GetProducts]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_GetProducts]
as
	select * from Products where Status = 1


GO
/****** Object:  StoredProcedure [dbo].[usp_GetProvider]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_GetProvider]
as
	select * from Provider where Status = 1


GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserInfo]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_GetUserInfo]
as
	select * from UserInfo where Status = 1


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertCategory]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_InsertCategory]
@CategoryName nvarchar(255),
@ParentId int,
@MetaLink ntext,
@DisplayNo int,
@IconImg ntext,
@FeatureImg ntext,
@Description ntext,
@ShowHome int,
@Status int,
@Error nvarchar(256) output
as
if(@CategoryName in (select CategoryName from Category))
begin
	set @Error=N'Tên loại này đã có rồi'
	return
end
	insert into Category VALUES (@CategoryName, @ParentId, @MetaLink,@DisplayNo,@IconImg,@FeatureImg,@Description,@ShowHome,@Status);
	set @Error=''

GO
/****** Object:  StoredProcedure [dbo].[usp_InsertCustomer]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_InsertCustomer]
	@FullName nvarchar(100),
	@PassWord nvarchar(256),
	@Address nvarchar(256),
	@Phone varchar(48),
	@Email varchar(256),
	@Avatar varchar(256),
	@Balance float,
	@CreateDate datetime,
	@CodeConfirm varchar,
	@Status tinyint,
	@returnCode nvarchar(4000) OUTPUT

AS
BEGIN
	BEGIN TRY
		IF(SELECT COUNT(*) FROM Customer WHERE FullName = @FullName) > 0
			BEGIN
				SET @returnCode = N'Thao tác thất bại! Khách hàng đã tồn tại!';
			END
		ELSE
			BEGIN
				IF(SELECT COUNT(*) FROM Customer WHERE Email = @Email) > 0
					BEGIN
						SET @returnCode = N'Địa chỉ Email đã tồn tại!';
					END
				ELSE
					BEGIN
						INSERT INTO Customer
						VALUES (@FullName,@PassWord, @Address, @Phone, @Email, @Avatar, @Balance, @CreateDate, @CodeConfirm, @Status);
						SET @returnCode = 'Success';
					END
			END
	END TRY
	BEGIN CATCH
		SET @returnCode = ERROR_MESSAGE();
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertProducts]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_InsertProducts]
	@ProductName nvarchar(256),
	@IconImg ntext,
	@Screen varchar(128),
	@Battery varchar(128),
	@CPU varchar(128),
	@Ram varchar(128),
	@Camera varchar(128),
	@Color varchar(128),
	@Osystem varchar(128),
	@Description ntext,
	@Discount int,
	@PriceIn float,
	@PriceOut float,
	@CategoryId int,
	@ProviderId int,
	@Quantity int,
	@CoutView int,
	@CoutBuy int,
	@CreateDate datetime,
	@Status tinyint,
	@UserId int,
	@returnCode nvarchar(4000) OUTPUT

AS
BEGIN
	BEGIN TRY
		IF(SELECT COUNT(*) FROM Products WHERE ProductName = @ProductName) > 0
			BEGIN
				SET @returnCode = N'Thao tác thất bại! Mặt hàng đã tồn tại!';
			END
		ELSE
			BEGIN
				INSERT INTO Products
				VALUES (@ProductName, @IconImg, @Screen, @Battery, @CPU, @Ram, @Camera, @Color, @Osystem, @Description,
				@Discount, @PriceIn, @PriceOut, @CategoryId, @ProviderId, @Quantity, @CoutView, @CoutBuy,@CreateDate,
				@Status, @UserId);
				SET @returnCode = 'Success';
			END
	END TRY
	BEGIN CATCH
		SET @returnCode = ERROR_MESSAGE();
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertProvider]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_InsertProvider]
	@ProviderName nvarchar(256),
	@IconImg ntext,
	@Description ntext,
	@Status tinyint,
	@returnCode nvarchar(4000) OUTPUT

AS
BEGIN
	BEGIN TRY
		IF(SELECT COUNT(*) FROM Provider WHERE ProviderName = @ProviderName) > 0
			BEGIN
				SET @returnCode = N'Thao tác thất bại! Nhà cung cấp đã tồn tại!';
			END
		ELSE
			BEGIN
				INSERT INTO Provider
				VALUES (@ProviderName, @IconImg, @Description, @Status);
				SET @returnCode = 'Success';
			END
	END TRY
	BEGIN CATCH
		SET @returnCode = ERROR_MESSAGE();
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUserInfo]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_InsertUserInfo]
	@UserName varchar(64),
	@FullName nvarchar(64),
	@PassWord varchar(256),
	@Email varchar(256),
	@Avatar varchar(256),
	@IsAdmin tinyint,
	@CodeConfirm varchar(10),
	@Allower tinyint,
	@CreateDate datetime,
	@Status tinyint,
@Error nvarchar(256) output
as
if(@UserName in (select UserName from [userinfo]))
begin
	set @Error=N'Tên loại này đã có rồi'
	return
end
	insert into [userinfo] VALUES (@UserName, @FullName, @PassWord, @Email, @Avatar, @IsAdmin, @CodeConfirm, @Allower, @CreateDate, @Status);
	set @Error=''


GO
/****** Object:  StoredProcedure [dbo].[usp_TopProvider]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_TopProvider]   
AS
BEGIN
          select i.ProviderId,i.ProviderName from (select top 4  ProviderId from products where Status=1  group by ProviderId order by sum(CoutBuy) desc) as p 
		left join Provider i on p.ProviderId=i.ProviderId where i.Status=1
END
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateCategory]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_UpdateCategory]
@CategoryId int,
@CategoryName nvarchar(255),
@ParentId int,
@MetaLink ntext,
@DisplayNo int,
@IconImg ntext,
@FeatureImg ntext,
@Description ntext,
@ShowHome int,
@Status int,
@Error nvarchar(256) output
as
if(@CategoryName in (select CategoryName from Category where CategoryId <> @CategoryId))
begin
	set @Error=N'Tên Catagory này trùng với tên một Catagory đã có khác'
	return
end
	Update Category Set CategoryName = @CategoryName,
		ParentId = @ParentId,
		MetaLink = @MetaLink,
		DisplayNo = @DisplayNo,
		IconImg = @IconImg,
		FeatureImg = @FeatureImg,
		Description = @Description,
		ShowHome = @ShowHome,
		Status = @Status where CategoryId = @CategoryId
	set @Error=''



GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateCustomer]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_UpdateCustomer]
	@CustomerId int,
	@FullName nvarchar(100),
	@PassWord nvarchar(256),
	@Address nvarchar(256),
	@Phone varchar(48),
	@Email varchar(256),
	@Avatar varchar(256),
	@Balance float,
	@CreateDate datetime,
	@CodeConfirm varchar,
	@Status tinyint,
	@returnCode nvarchar(4000) OUTPUT

AS
BEGIN
	BEGIN TRY
		IF(SELECT COUNT(*) FROM Customer WHERE FullName = @FullName and CustomerId <> @CustomerId) > 0
			BEGIN
				SET @returnCode = N'Thao tác thất bại! Trùng tên khách hàng đã tồn tại!';
			END
		ELSE
			BEGIN
				IF(SELECT COUNT(*) FROM Customer WHERE Email = @Email and CustomerId <> @CustomerId) > 0
					BEGIN
						SET @returnCode = N'Trùng Địa chỉ Email của khách hàng khác!';
					END
				ELSE
					BEGIN
						Update Customer
						set FullName = @FullName,
							PassWord = @PassWord,
							Address = @Address,
							Phone = @Phone,
							Email = @Email,
							Avatar = @Avatar,
							Balance = @Balance,
							CreateDate = @CreateDate,
							CodeConfirm = @CodeConfirm,
							Status = @Status Where CustomerId = @CustomerId
						SET @returnCode = 'Success';
					END
			END
	END TRY
	BEGIN CATCH
		SET @returnCode = ERROR_MESSAGE();
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateProducts]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_UpdateProducts]
	@ProductId int,
	@ProductName nvarchar(256),
	@IconImg ntext,
	@Screen varchar(128),
	@Battery varchar(128),
	@CPU varchar(128),
	@Ram varchar(128),
	@Camera varchar(128),
	@Color varchar(128),
	@Osystem varchar(128),
	@Description ntext,
	@Discount int,
	@PriceIn float,
	@PriceOut float,
	@CategoryId int,
	@ProviderId int,
	@Quantity int,
	@CoutView int,
	@CoutBuy int,
	@CreateDate datetime,
	@Status tinyint,
	@UserId int,
	@returnCode nvarchar(4000) OUTPUT

AS
BEGIN
	BEGIN TRY
		IF(SELECT COUNT(*) FROM Products WHERE ProductName = @ProductName And ProductId <> @ProductId) > 0
			BEGIN
				SET @returnCode = N'Thao tác thất bại! Trùng tên với mặt hàng đã tồn tại!';
			END
		ELSE
			BEGIN
				Update Products
				Set ProductName = @ProductName,
				IconImg = @IconImg,
				Screen = @Screen,
				Battery = @Battery,
				CPU = @CPU,
				Ram = @Ram,
				Camera = @Camera,
				Color = @Color,
				Osystem = @Osystem,
				Description = @Description,
				Discount = @Discount,
				PriceIn = @PriceIn,
				PriceOut = @PriceOut,
				CategoryId = @CategoryId,
				ProviderId = @ProviderId,
				Quantity = @Quantity,
				CoutView = @CoutView,
				CoutBuy = @CoutBuy,
				CreateDate = @CreateDate,
				Status = @Status,
				UserId = @UserId Where ProductId = @ProductId
				SET @returnCode = 'Success';
			END
	END TRY
	BEGIN CATCH
		SET @returnCode = ERROR_MESSAGE();
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateProvider]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_UpdateProvider]
	@ProviderId int,
	@ProviderName nvarchar(256),
	@IconImg ntext,
	@Description ntext,
	@Status tinyint,
	@returnCode nvarchar(4000) OUTPUT

AS
BEGIN
	BEGIN TRY
		IF(SELECT COUNT(*) FROM Provider WHERE ProviderName = @ProviderName and ProviderId <> @ProviderId) > 0
			BEGIN
				SET @returnCode = N'Thao tác thất bại! Trùng tên với nhà cung cấp khác đã tồn tại!';
			END
		ELSE
			BEGIN
				Update Provider
					Set ProviderName = @ProviderName,
					IconImg = @IconImg,
					Description = @Description,
					Status = @Status where ProviderId = @ProviderId

				SET @returnCode = 'Success';
			END
	END TRY
	BEGIN CATCH
		SET @returnCode = ERROR_MESSAGE();
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateUserInfo]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[usp_UpdateUserInfo]
	@UserId int,
	@UserName varchar(64),
	@FullName nvarchar(64),
	@PassWord varchar(256),
	@Email varchar(256),
	@Avatar varchar(256),
	@IsAdmin tinyint,
	@CodeConfirm varchar(10),
	@Allower tinyint,
	@CreateDate datetime,
	@Status tinyint,
@Error nvarchar(256) output
as
if(@UserName in (select UserName from [userinfo] where UserId <> @UserId))
begin
	set @Error=N'Trùng với tên của người sử dụng đã có, Xin kiểm tra lại!!!'
	return
end
	Update [userinfo] 
		Set UserName = @UserName,
			FullName = @FullName,
			PassWord = @PassWord,
			Email = @Email,
			Avatar = @Avatar,
			IsAdmin = @IsAdmin,
			CodeConfirm = @CodeConfirm,
			Allower = @Allower,
			CreateDate = @CreateDate,
			Status = @Status Where UserId = @UserId
	set @Error=''


GO
/****** Object:  Table [dbo].[Business]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Business](
	[BusinessId] [varchar](100) NOT NULL,
	[BusinessName] [nvarchar](256) NOT NULL,
	[Status] [tinyint] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Category]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](256) NOT NULL,
	[ParentId] [int] NULL,
	[MetaLink] [ntext] NULL,
	[DisplayNo] [int] NOT NULL,
	[IconImg] [ntext] NULL,
	[FeatureImg] [ntext] NULL,
	[Description] [ntext] NULL,
	[ShowHome] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
 CONSTRAINT [PK_dbo.Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[PassWord] [varchar](256) NOT NULL,
	[Address] [nvarchar](256) NOT NULL,
	[Phone] [varchar](48) NOT NULL,
	[Email] [varchar](256) NULL,
	[Avatar] [varchar](256) NULL,
	[Balance] [float] NULL,
	[CreateDate] [datetime] NOT NULL,
	[CodeConfirm] [varchar](10) NOT NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_dbo.ContactInfo] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Feeback]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Feeback](
	[FeedbackId] [int] IDENTITY(1,1) NOT NULL,
	[FulltName] [nvarchar](256) NOT NULL,
	[Email] [varchar](128) NOT NULL,
	[Title] [varchar](128) NOT NULL,
	[Content] [ntext] NULL,
	[CreateDate] [datetime] NOT NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_dbo.Feeback] PRIMARY KEY CLUSTERED 
(
	[FeedbackId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GrandPermission]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrandPermission](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Status] [tinyint] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[News]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[PostTitile] [nvarchar](256) NOT NULL,
	[CategoryId] [int] NULL,
	[PostContent] [ntext] NULL,
	[Author] [nvarchar](256) NOT NULL,
	[Description] [ntext] NULL,
	[FeatureImg] [ntext] NULL,
	[CreateDate] [datetime] NOT NULL,
	[Status] [tinyint] NOT NULL,
 CONSTRAINT [PK_dbo.News] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderDetail] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Value] [float] NOT NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderNo] [varchar](12) NOT NULL,
	[CustomerId] [int] NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](256) NOT NULL,
	[Phone] [varchar](48) NOT NULL,
	[Email] [varchar](256) NULL,
	[Avatar] [varchar](256) NULL,
	[Total] [float] NULL,
	[CreateDate] [datetime] NOT NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_dbo.Voucher] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Permission](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[PermissionName] [nvarchar](256) NOT NULL,
	[Description] [ntext] NULL,
	[BusinessId] [varchar](100) NOT NULL,
	[Status] [tinyint] NOT NULL,
 CONSTRAINT [PK_dbo.Permission] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Products]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](256) NOT NULL,
	[IconImg] [ntext] NULL,
	[Screen] [varchar](128) NOT NULL,
	[Battery] [varchar](128) NOT NULL,
	[CPU] [varchar](128) NOT NULL,
	[Ram] [varchar](128) NULL,
	[Camera] [varchar](128) NOT NULL,
	[Color] [varchar](128) NOT NULL,
	[Osystem] [varchar](128) NOT NULL,
	[Description] [ntext] NULL,
	[Discount] [int] NOT NULL,
	[PriceIn] [float] NOT NULL,
	[PriceOut] [float] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[ProviderId] [int] NOT NULL,
	[Quantity] [int] NULL,
	[CoutView] [int] NULL,
	[CoutBuy] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[Status] [tinyint] NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_dbo.Products] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Provider]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provider](
	[ProviderId] [int] IDENTITY(1,1) NOT NULL,
	[ProviderName] [nvarchar](256) NOT NULL,
	[IconImg] [ntext] NULL,
	[Description] [ntext] NULL,
	[Status] [tinyint] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Provider] PRIMARY KEY CLUSTERED 
(
	[ProviderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Slider]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Slider](
	[SliderId] [int] IDENTITY(1,1) NOT NULL,
	[SliderImg] [varchar](256) NOT NULL,
	[DisplayNo] [int] NULL,
	[Description] [ntext] NULL,
	[Status] [tinyint] NOT NULL,
 CONSTRAINT [PK_dbo.Slider] PRIMARY KEY CLUSTERED 
(
	[SliderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 1/25/2018 3:25:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](64) NOT NULL,
	[FullName] [nvarchar](64) NOT NULL,
	[PassWord] [varchar](256) NOT NULL,
	[Email] [varchar](256) NULL,
	[Avatar] [varchar](256) NULL,
	[IsAdmin] [tinyint] NULL,
	[CodeConfirm] [varchar](10) NULL,
	[Allower] [tinyint] NULL,
	[CreateDate] [datetime] NOT NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_dbo.User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (1, N'Apple', NULL, NULL, 1, NULL, N'/Content/phone/images/iphone-X.png', NULL, 1, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (2, N'Samsung', NULL, NULL, 2, NULL, N'/Content/phone/images/note8.png', NULL, 1, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (4, N'Contact', NULL, N'/Common/ContactPage/', 4, NULL, NULL, NULL, 1, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (5, N'IPhone X', 1, NULL, 1, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (6, N'IPhone 8  Plus', 1, NULL, 2, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (8, N'IPhone 8', 1, NULL, 3, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (9, N'IPhone 7 Plus', 1, NULL, 4, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (10, N'IPhone 7', 1, NULL, 5, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (11, N'Galaxy Note 8', 2, NULL, 1, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (12, N'Galaxy S8 Plus', 2, NULL, 2, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (13, N'Galaxy S8', 2, NULL, 3, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (14, N'Galaxy Note FE', 2, NULL, 4, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (15, N'Galaxy C9 Pro', 2, NULL, 5, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (16, N'Galaxy A8+(2018)', 2, NULL, 6, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (17, N'Galaxy A7(2017)', 2, NULL, 7, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (18, N'Galaxy J7 Prime', 2, NULL, 8, NULL, NULL, NULL, 2, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (19, N'Oppo', NULL, NULL, 5, NULL, NULL, NULL, 0, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (20, N'Oppo A83', 19, NULL, 1, NULL, NULL, NULL, 0, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (21, N'Asus', NULL, NULL, 6, NULL, NULL, NULL, 0, 1, 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [ParentId], [MetaLink], [DisplayNo], [IconImg], [FeatureImg], [Description], [ShowHome], [UserId], [Status]) VALUES (22, N'Sony', NULL, NULL, 7, NULL, NULL, NULL, 0, 1, 1)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (4, N'1234', N'1234', N'1234', N'1234', N'141', N'24', 1234, CAST(N'2018-01-02 00:00:00.000' AS DateTime), N'124', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (5, N'123', N'123', N'123', N'123', N'123', NULL, NULL, CAST(N'2018-01-02 12:02:24.717' AS DateTime), N'1234', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (6, N'long', N'long', N'long', N'long', N'long', NULL, NULL, CAST(N'2018-01-02 14:22:26.583' AS DateTime), N'1602', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (7, N'Vũ Cao Long', N'2BE1333893C12E25A07E17D6558CC8C7', N'Hải Dương', N'0989602497', N'caolong2497@gmail.com', NULL, NULL, CAST(N'2018-01-02 15:22:03.520' AS DateTime), N'abcxyz123', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (8, N'123', N'123', N'123', N'123', N'thanhlong@gmail.com', NULL, NULL, CAST(N'2018-01-02 15:26:21.753' AS DateTime), N'2509', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (9, N'123', N'12345678', N'1234', N'0123412340', N'123@gmail.com', NULL, NULL, CAST(N'2018-01-02 15:39:11.263' AS DateTime), N'3549', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (10, N'long12345', N'12345678', N'123', N'0123445123', N'1234@gmail.com', NULL, NULL, CAST(N'2018-01-02 16:03:02.730' AS DateTime), N'9328', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (11, N'long1231', N'25D55AD283AA400AF464C76D713C07AD', N'123124', N'0123451123', N'long123@gmail.com', NULL, NULL, CAST(N'2018-01-02 16:54:46.567' AS DateTime), N'6420', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (12, N'vucaolong', N'A8F18DED442E5FF468BC8AFAF0BA58BA', N'12341', N'0123412415', N'1234@gmail.com', NULL, NULL, CAST(N'2018-01-03 14:59:51.307' AS DateTime), N'8505', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (13, N'long12345', N'25F9E794323B453885F5181F1B624D0B', N'long', N'0989602488', N'long1234@gmail.com', NULL, NULL, CAST(N'2018-01-03 15:00:45.300' AS DateTime), N'4978', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (14, N'long1234123', N'25F9E794323B453885F5181F1B624D0B', N'123', N'0989602497', N'dvhop@gmail.com', NULL, NULL, CAST(N'2018-01-19 10:21:37.093' AS DateTime), N'4747', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (15, N'long1234', N'835718CD98DD945614F938BE046138AA', N'long', N'0989602497', N'hopdv@gmail.com', NULL, NULL, CAST(N'2018-01-19 11:10:19.370' AS DateTime), N'8117', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (16, N'long', N'835718CD98DD945614F938BE046138AA', N'dsf', N'0989602497', N'long@gmail.com', NULL, NULL, CAST(N'2018-01-19 14:08:47.077' AS DateTime), N'9240', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (17, N'Đinh Văn Hợp', N'E807F1FCF82D132F9BB018CA6738A19F', N'hải dương', N'0989602497', N'hopdv@gmail.com', NULL, NULL, CAST(N'2018-01-19 14:13:02.290' AS DateTime), N'4807', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (18, N'sdf', N'835718CD98DD945614F938BE046138AA', N'long', N'0989602497', N'hopdv@gmail.com', NULL, NULL, CAST(N'2018-01-19 14:17:42.247' AS DateTime), N'3842', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (19, N'sdf', N'25F9E794323B453885F5181F1B624D0B', N'123456', N'0989602497', N'caolong2497s@gmail.com', NULL, NULL, CAST(N'2018-01-19 14:18:39.643' AS DateTime), N'3741', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (20, N'sádf', N'25F9E794323B453885F5181F1B624D0B', N'sdf', N'0989602497', N'hopdv@gmail.com', NULL, NULL, CAST(N'2018-01-19 14:29:39.343' AS DateTime), N'8664', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (21, N'long', N'835718CD98DD945614F938BE046138AA', N'long123', N'0989602497', N'hospdv@gmail.com', NULL, NULL, CAST(N'2018-01-19 14:35:16.000' AS DateTime), N'9915', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (22, N'caolong2497', N'25F9E794323B453885F5181F1B624D0B', N'123', N'0989602497', N'hopdsv@gmail.com', NULL, NULL, CAST(N'2018-01-19 14:37:04.917' AS DateTime), N'1704', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (23, N'Vũ Cao Long', N'36ED58C5C14DC2F58EEF099585D2A939', N'Hải Dương', N'0989602497', N'caolong123123@gmail.com', NULL, NULL, CAST(N'2018-01-22 10:01:41.947' AS DateTime), N'6365', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (24, N'Thanh Long', N'E10ADC3949BA59ABBE56E057F20F883E', N'Hải Dươngs', N'0989602498', N'thanhlong123@gmail.com', NULL, NULL, CAST(N'2018-01-22 10:04:20.717' AS DateTime), N'7480', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (25, N'Vũ Cao Long', N'36ED58C5C14DC2F58EEF099585D2A939', N'Hải Dương', N'0989602497', N'longlong97@gmail.com', NULL, NULL, CAST(N'2018-01-25 09:28:29.197' AS DateTime), N'5003', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (26, N'Cao Long', N'835718CD98DD945614F938BE046138AA', N'Hải Dương', N'0989602497', N'caolong24927@gmail.com', NULL, NULL, CAST(N'2018-01-25 09:29:26.810' AS DateTime), N'4304', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (27, N'vucao long', N'25F9E794323B453885F5181F1B624D0B', N'123456789', N'0989602497', N'long123123@gmail.com', NULL, NULL, CAST(N'2018-01-25 09:53:22.180' AS DateTime), N'1437', 1)
INSERT [dbo].[Customer] ([CustomerId], [FullName], [PassWord], [Address], [Phone], [Email], [Avatar], [Balance], [CreateDate], [CodeConfirm], [Status]) VALUES (28, N'Vương Văn Toàn', N'25F9E794323B453885F5181F1B624D0B', N'56', N'0989602497', N'toan2497@gmail.com', NULL, NULL, CAST(N'2018-01-25 15:14:18.453' AS DateTime), N'7801', 1)
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (1, 8, 1, 2, 12000000, 240000000000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (2, 9, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (3, 9, 32, 1, 12000000, 11400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (4, 10, 32, 1, 12000000, 11400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (5, 10, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (6, 11, 32, 1, 12000000, 11400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (7, 11, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (8, 12, 32, 1, 12000000, 11400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (9, 12, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (10, 13, 3, 1, 24000000, 23280000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (11, 14, 3, 1, 24000000, 23280000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (12, 15, 3, 1, 24000000, 23280000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (13, 16, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (14, 16, 32, 1, 12000000, 11400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (15, 17, 4, 6, 35000000, 201600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (16, 17, 32, 2, 12000000, 22800000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (17, 17, 27, 1, 12345654, 12222197.46, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (18, 18, 28, 4, 12341233, 27644361.92, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (19, 19, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (20, 21, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (21, 21, 32, 1, 12000000, 11400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (25, 22, 27, 1, 12345654, 12222197.46, NULL)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (26, 22, 4, 1, 35000000, 33600000, NULL)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (27, 22, 32, 1, 12000000, 11400000, NULL)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (28, 23, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (29, 23, 32, 1, 12000000, 11400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (30, 24, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (31, 26, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (32, 26, 29, 1, 1123, -258.29, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (33, 27, 1, 3, 12000000, 36000000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (34, 28, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (35, 28, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (36, 28, 27, 1, 12345654, 12222197.46, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (37, 28, 32, 1, 12000000, 11400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (38, 28, 28, 1, 12341233, 6911090.48, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (39, 29, 4, 2, 35000000, 67200000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (40, 29, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (41, 30, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (42, 30, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (43, 31, 29, 1, 1123, -258.29, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (44, 31, 5, 2, 35000000, 66500000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (45, 31, 4, 3, 35000000, 100800000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (46, 31, 27, 1, 12345654, 12222197.46, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (47, 31, 28, 1, 12341233, 6911090.48, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (48, 32, 4, 2, 35000000, 67200000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (49, 32, 5, 3, 35000000, 99750000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (50, 32, 28, 2, 12341233, 13822180.96, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (51, 33, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (52, 33, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (53, 34, 4, 4, 35000000, 134400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (54, 34, 5, 4, 35000000, 133000000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (55, 35, 4, 6, 35000000, 201600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (56, 35, 5, 2, 35000000, 66500000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (57, 36, 4, 4, 35000000, 134400000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (58, 36, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (59, 38, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (60, 38, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (61, 39, 4, 2, 35000000, 67200000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (62, 39, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (63, 40, 4, 2, 35000000, 67200000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (64, 40, 5, 2, 35000000, 66500000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (65, 41, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (66, 41, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (67, 42, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (68, 42, 28, 1, 12341233, 6911090.48, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (69, 43, 29, 1, 1123, -258.29, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (70, 43, 1, 1, 12000000, 12000000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (71, 44, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (72, 44, 28, 1, 12341233, 6911090.48, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (73, 45, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (74, 46, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (75, 47, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (76, 47, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (77, 47, 28, 1, 12341233, 6911090.48, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (78, 48, 4, 1, 35000000, 33600000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (79, 48, 5, 1, 35000000, 33250000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (80, 49, 4, 2, 35000000, 67200000, 1)
INSERT [dbo].[OrderDetail] ([OrderDetail], [OrderId], [ProductId], [Quantity], [Price], [Value], [Status]) VALUES (81, 49, 5, 1, 35000000, 33250000, 1)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (1, N'123', NULL, N'234', N'123', N'123', N'13', NULL, NULL, CAST(N'2018-01-16 10:16:12.433' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (2, N'123', NULL, N'1234', N'12345', N'12345', N'12345', NULL, NULL, CAST(N'2018-01-16 11:02:24.533' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (3, N'123', NULL, N'124124', N'124124', N'124124', N'124124', NULL, NULL, CAST(N'2018-01-16 11:05:54.967' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (4, N'123', NULL, N'124124', N'124124', N'124124', N'124124', NULL, NULL, CAST(N'2018-01-16 11:06:11.893' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (5, N'123', NULL, N'124124', N'124124', N'124124', N'124124', NULL, NULL, CAST(N'2018-01-16 11:06:15.860' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (6, N'123', NULL, N'123', N'123213', N'123123', N'12312321', NULL, NULL, CAST(N'2018-01-16 11:08:44.817' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (7, N'123', NULL, N'123', N'123213', N'123123', N'12312321', NULL, NULL, CAST(N'2018-01-16 11:09:46.027' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (8, N'123', NULL, N'123', N'123', N'123', N'123', NULL, NULL, CAST(N'2018-01-16 11:22:13.573' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (9, N'123', NULL, N'Long', N'long', N'long', N'long', NULL, NULL, CAST(N'2018-01-16 11:24:17.847' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (10, N'123', NULL, N'2134214', N'124214', N'124214', N'124214', NULL, 0, CAST(N'2018-01-16 11:30:03.697' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (11, N'123', NULL, N'213421433', N'12421433', N'124214133', N'12421433', NULL, 0, CAST(N'2018-01-16 11:31:51.280' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (12, N'123', NULL, N'1', N'1', N'1', N'1', NULL, 0, CAST(N'2018-01-16 11:32:32.607' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (13, N'123', NULL, N'áda', N'ádasd', N'a´dasd', N'adasd', NULL, 0, CAST(N'2018-01-16 11:41:28.513' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (14, N'123', NULL, N'ád', N'ádaa', N'a´d', N'a´d', NULL, 23280000, CAST(N'2018-01-16 11:44:43.820' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (15, N'123', NULL, N'ss', N'ss', N'ss', N'ss', NULL, 23280000, CAST(N'2018-01-16 11:46:30.277' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (16, N'123', NULL, N'bvn', N'bvn', N'vbn', N'vbn', NULL, 45000000, CAST(N'2018-01-16 11:47:38.693' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (17, N'123', NULL, N'dfsdf', N'sdfdsf', N'sdfdsf', N'sdfdsf', NULL, 236622197.46, CAST(N'2018-01-16 14:20:54.727' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (18, N'123', NULL, N'dd', N'đ', N'd', N'd', NULL, 100450000, CAST(N'2018-01-16 14:56:27.300' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (19, N'123', NULL, N'x', N'x', N'x', N'x', NULL, 33600000, CAST(N'2018-01-16 15:35:21.547' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (20, N'123', NULL, N'x', N'x', N'x', N'x', NULL, 33600000, CAST(N'2018-01-16 15:35:39.487' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (21, N'123', NULL, N'd', N'd', N'd', N'd', NULL, 45000000, CAST(N'2018-01-16 15:36:49.147' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (22, N'123', NULL, N'sd', N'sd', N'sd', N'sd', NULL, 57222197.46, CAST(N'2018-01-16 16:22:55.740' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (23, N'123', NULL, N'dcvxcv', N'xcvxcv', N'xcvxcv', N'xcvxcv', NULL, 45000000, CAST(N'2018-01-17 09:58:31.733' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (24, N'123', NULL, N'123', N'123', N'13', N'123', NULL, 33600000, CAST(N'2018-01-17 15:48:45.533' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (25, N'123', NULL, N'hjk', N'jk', N'hjk', N'hjk', NULL, 33600000, CAST(N'2018-01-17 15:49:06.897' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (26, N'123', NULL, N'vcb', N'cvb', N'cvb', N'cvb', NULL, 33599741.71, CAST(N'2018-01-18 10:10:26.003' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (27, N'123', NULL, N'd', N'd', N'd', N'd', NULL, 36000000, CAST(N'2018-01-18 11:20:30.410' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (28, N'123', 7, N'Đinh Văn Hợp', N'1234564789', N'0989602497', N'hopdv@gmail.com', NULL, 97383287.94, CAST(N'2018-01-25 10:04:40.897' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (29, N'123', 7, N'long', N'123', N'0989602497', N'123456789@gmail.com', NULL, 100450000, CAST(N'2018-01-25 10:09:44.390' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (30, N'123', 0, N'Vũ Cao Long', N'1234124', N'0989602497', N'21232@gmail.com', NULL, 66850000, CAST(N'2018-01-25 11:21:06.783' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (31, N'123', 0, N'1231321', N'123456', N'0989602498', N'123456@gmail.com', NULL, 186433029.65, CAST(N'2018-01-25 11:21:54.000' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (32, N'123', 0, N'dssd', N'123456487', N'0123456789', N'255654@gmail.com', NULL, 180772180.96, CAST(N'2018-01-25 11:23:02.343' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (33, N'123', 0, N'hợp', N'213', N'0986565655', N'123@gmail.com', NULL, 66850000, CAST(N'2018-01-25 11:24:06.127' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (34, N'123', 0, N'Toàn', N'121321', N'0989899898', N'caolong2497@gmail.com', NULL, 267400000, CAST(N'2018-01-25 11:26:03.630' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (35, N'123', 0, N'dan', N'1231321', N'0989602497', N'caolong2@gmail.com', NULL, 268100000, CAST(N'2018-01-25 11:28:58.377' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (36, N'123', 0, N'aaa', N'1', N'0912354536', N'aaaa@gmail.com', NULL, 167650000, CAST(N'2018-01-25 11:33:39.553' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (37, N'123', 0, N'aaa', N'a', N'0912354536', N'a@gmail.com', NULL, 167650000, CAST(N'2018-01-25 11:36:20.527' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (38, N'123', 0, N'a', N'a', N'0912354536', N'A@gmail.com', NULL, 66850000, CAST(N'2018-01-25 11:37:01.020' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (39, N'123', 0, N'a', N'a', N'0912354536', N'a@gmail.com', NULL, 100450000, CAST(N'2018-01-25 11:39:24.077' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (40, N'123', 0, N'a', N'a', N'0912354536', N'a@gmail.com', NULL, 133700000, CAST(N'2018-01-25 11:40:10.290' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (41, N'123', 0, N'0989602497', N'456', N'0989602497', N'0989602497@gmail.com', NULL, 66850000, CAST(N'2018-01-25 11:42:58.260' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (42, N'123', 0, N'a', N'a', N'0912354536', N'a@gmail.com', NULL, 40161090.48, CAST(N'2018-01-25 11:44:07.773' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (43, N'123', 0, N'a', N's', N'0912354536', N'a@gmail.com', NULL, 11999741.71, CAST(N'2018-01-25 11:45:02.493' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (44, N'123', 0, N'a', N'a', N'0912354536', N'A@gmail.com', NULL, 40161090.48, CAST(N'2018-01-25 11:46:25.697' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (45, N'123', 0, N'a', N'k', N'0912354536', N'a@gmail.com', NULL, 33600000, CAST(N'2018-01-25 11:47:04.537' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (46, N'123', 0, N'a', N'a', N'0912354536', N'a@gmail.com', NULL, 33600000, CAST(N'2018-01-25 11:49:20.767' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (47, N'123', 0, N'Vũ Cao Long', N'Hải Dương', N'09896024978s', N'long123@gmail.com', NULL, 73761090.48, CAST(N'2018-01-25 13:41:29.117' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (48, N'123', 7, N'd', N'123456', N'09896021497', N'long123@gmail.com', NULL, 66850000, CAST(N'2018-01-25 13:59:45.753' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderId], [OrderNo], [CustomerId], [FullName], [Address], [Phone], [Email], [Avatar], [Total], [CreateDate], [Status]) VALUES (49, N'123', 28, N'Long', N'long123', N'0989602497', N'coalong2497@gmail.com', NULL, 100450000, CAST(N'2018-01-25 15:18:11.210' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (1, N'Iphone X 64GB', N'/Content/phone/images/Iphone8plus_item.png', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', 0, 1, 12000000, 5, 1, 1, 17, 16, CAST(N'1900-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (2, N'Iphone 8', N'/Content/phone/images/Iphone8plus_item.png', N'2', N'2', N'2', N'2', N'2', N'2', N'2', N'2', 0, 2, 24000000, 8, 1, 1, 14, 14, CAST(N'1900-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (3, N'Iphone 8 Plus', N'/Content/phone/images/Iphone8plus_item.png,/Content/phone/images/iphone8plus_item2.jpg,/Content/phone/images/iphone8plus_item3.jpg', N'3', N'3', N'3', N'3', N'3', N'3', N'3', N'3', 3, 3, 24000000, 6, 1, 1, 16, 15, CAST(N'2017-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (4, N'Iphone 7 Plus', N'/Content/phone/images/Iphone8plus_item.png', N'4', N'4', N'4', N'4', N'4', N'4', N'4', N'4', 4, 4, 35000000, 4, 1, 1, 2005, 2036, CAST(N'2017-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (5, N'Iphone 7', N'/Content/phone/images/Iphone8plus_item.png', N'5', N'5', N'5', N'5', N'5', N'5', N'5', N'5', 5, 5, 35000000, 5, 1, 1, 123, 149, CAST(N'2017-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (7, N'Galaxy Note 8', N'/Content/phone/images/GalaxyNote8_item.png', N'6', N'6', N'6', N'6', N'6', N'6', N'6', N'6', 6, 6, 24000000, 2, 2, 1, 1, 1, CAST(N'2016-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (10, N'Galaxy S8 Plus', N'/Content/phone/images/GalaxyS8_item.jpg', N'7', N'7', N'7', N'7', N'7', N'7', N'7', N'7', 7, 7, 24000000, 2, 2, 1, 224, 123, CAST(N'2017-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (12, N'Galaxy S8 ', N'/Content/phone/images/Galaxy8_item.jpg', N'12', N'12', N'12', N'12', N'12', N'12', N'12', N'12', 0, 12, 24000000, 2, 2, 1, 123, 123, CAST(N'2018-08-08 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (15, N'Galaxy A7', N'/Content/phone/images/GalaxyNote8_item.png', N'1123', N'123', N'123', N'12', N'3123', N'123', N'213', N'123', 123, 123, 24000000, 2, 2, 1, 123, 123, CAST(N'2017-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (17, N'Oppo A83', N'/Content/phone/images/OppoA83_item.jpg', N'123', N'123', N'21', N'3', N'23', N'123', N'123', N'123', 123, 123, 24000000, 19, 3, 1, 123, 123, CAST(N'2010-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (18, N'Oppo F3', N'/Content/phone/images/OppoF3.jpg', N'13', N'12', N'321', N'3', N'123', N'123', N'123', N'123', 123, 123, 24000000, 19, 3, 1, 123, 123, CAST(N'1900-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (19, N'Oppo F4', N'/Content/phone/images/OppoA83_item.jpg', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', 1, 1, 24000000, 19, 3, 1, 124, 123, CAST(N'2010-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (22, N'Asus 1', N'/Content/phone/images/OppoF3.jpg', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', 1, 1, 24000000, 21, 4, 1, 12, 1, CAST(N'2010-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (23, N'Sony2', N'/Content/phone/images/OppoF3.jpg', N'2', N'2', N'2', N'2', N'2', N'2', N'2', N'2', 2, 2, 24000000, 22, 5, 1, 1, 1, CAST(N'2016-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (27, N'Iphone 6 Plus', N'/Content/phone/images/Iphone8plus_item.png', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', 1, 1, 12345654, 1, 1, 1, 12363, 12347, CAST(N'1900-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (28, N'Iphone 6', N'/Content/phone/images/Iphone8plus_item.png', N'4', N'4', N'4', N'4', N'4', N'4', N'4', N'4', 44, 4, 12341233, 1, 1, 1, 1123, 130, CAST(N'2010-12-13 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (29, N'Iphone 5', N'/Content/phone/images/Iphone8plus_item.png', N'123', N'123', N'123', N'123', N'123', N'12', N'123', N'123', 123, 123, 1123, 1, 1, 1, 123, 125, CAST(N'2010-01-01 00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([ProductId], [ProductName], [IconImg], [Screen], [Battery], [CPU], [Ram], [Camera], [Color], [Osystem], [Description], [Discount], [PriceIn], [PriceOut], [CategoryId], [ProviderId], [Quantity], [CoutView], [CoutBuy], [CreateDate], [Status], [UserId]) VALUES (32, N'Iphone X 256 GB', N'/Content/phone/images/Iphone8plus_item.png', N'1', N'1', N'1', N'1', N'1', N'1', N'1', N'1', 5, 123, 12000000, 5, 1, 1, 124, 124, CAST(N'2010-01-01 00:00:00.000' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Provider] ON 

INSERT [dbo].[Provider] ([ProviderId], [ProviderName], [IconImg], [Description], [Status], [UserId]) VALUES (1, N'Apple', N'/Content/phone/images/apple.png', N'apple', 1, 1)
INSERT [dbo].[Provider] ([ProviderId], [ProviderName], [IconImg], [Description], [Status], [UserId]) VALUES (2, N'Samsung', N'/Content/phone/images/samsung.png', N'samsung', 1, 1)
INSERT [dbo].[Provider] ([ProviderId], [ProviderName], [IconImg], [Description], [Status], [UserId]) VALUES (3, N'Oppo', N'/Content/phone/images/oppo.png', N'oppo', 1, 1)
INSERT [dbo].[Provider] ([ProviderId], [ProviderName], [IconImg], [Description], [Status], [UserId]) VALUES (4, N'Asus', N'/Content/phone/images/asus.png', N'Asus', 1, 1)
INSERT [dbo].[Provider] ([ProviderId], [ProviderName], [IconImg], [Description], [Status], [UserId]) VALUES (5, N'Sony', N'/Content/phone/images/sony.png', N'sony', 1, 1)
SET IDENTITY_INSERT [dbo].[Provider] OFF
SET IDENTITY_INSERT [dbo].[UserInfo] ON 

INSERT [dbo].[UserInfo] ([UserId], [UserName], [FullName], [PassWord], [Email], [Avatar], [IsAdmin], [CodeConfirm], [Allower], [CreateDate], [Status]) VALUES (1, N'Long', N'Vu Cao Long', N'123', N'123', N'123', 1, N'1234', 1, CAST(N'1900-01-01 00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[UserInfo] OFF
ALTER TABLE [dbo].[Category]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserInfo] ([UserId])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserInfo] ([UserId])
GO
ALTER TABLE [dbo].[Provider]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserInfo] ([UserId])
GO
