--------Cleaning Data in SQL Querries

------Select *
------from [Nashville Housing]

--------Standardize Date Format



--------Update [Nashville Housing]
--------set saledate = convert (date,saledate)

--------Alter table [Nashville Housing]
--------Add SaleDateConverted date;

------Update [Nashville Housing]
------set SaleDateConverted = convert (date,saledate)

------Select SaleDate, saledateconverted, convert (date,saledate)
------from [Nashville Housing]

--------Populate PropertyAddressData

----Select *
----from [Nashville Housing]
------where PropertyAddress is null
----order by ParcelID

------Join table on itself; If parcelID is the same in two rows, propertyaddress should be the same

----Select a.ParcelID, a.PropertyAddress, b.ParcelId,b.Propertyaddress,Isnull(a.PropertyAddress, b.PropertyAddress)
----from [Nashville Housing] a
----join [Nashville Housing]  b on
----a.ParcelID=b.ParcelID
----and a.UniqueID<> b.UniqueID
----where a.PropertyAddress is null

----update a
----set PropertyAddress =isnull(a.propertyaddress,b.propertyaddress)
----from [Nashville Housing] a
----join [Nashville Housing]  b on
----a.ParcelID=b.ParcelID
----and a.UniqueID<> b.UniqueID

------Breaking out adress into individual columns(city, street, state)

--Select PropertyAddress
--from [Nashville Housing]


--SELECT 
--Substring (PropertyAddress, 1, Charindex(',', PropertyAddress + ',') -1 ) AS Address
--,substring(propertyaddress, Charindex(',', PropertyAddress) +1, len(propertyaddress)) as Address
--from [Nashville Housing]

----Alter table [Nashville Housing]
----Add PropertySplitAddress nvarchar(255)

--Update [Nashville Housing]
--Set PropertySplitAddress = substring(PropertyAddress, 1, Charindex(',', PropertyAddress + ',') -1 )


----Alter table [Nashville Housing]
----Add PropertySplitcity nvarchar(255);

--Update [Nashville Housing]
--Set PropertySplitcity = substring (propertyaddress,Charindex(',', PropertyAddress) +1, len(propertyaddress))

--select *
--from [Nashville Housing]

--Select OwnerAddress
--from [Nashville Housing]

--select
--PARSENAME (replace (owneraddress, ',','.'),3)
--,PARSENAME (replace (owneraddress, ',','.'),2)
--,PARSENAME (replace (owneraddress, ',','.'),1)

--from [Nashville Housing]


--Alter table [Nashville Housing]
--Add OwnerSplitAddress nvarchar(255)


--Update [Nashville Housing]
--Set OwnerSplitAddress = PARSENAME (replace (owneraddress, ',','.'),3)



--Alter table [Nashville Housing]
--Add OwnerSplitcity nvarchar(255);

--Update [Nashville Housing]
--Set OwnerSplitCity = PARSENAME (replace (owneraddress, ',','.'),2)

--Alter table [Nashville Housing]
--Add OwnerSplitState nvarchar(255);

--Update [Nashville Housing]
--Set OwnerSplitState = PARSENAME (replace (owneraddress, ',','.'),1)

--select *
--from [Nashville Housing]

--Change Y and N to Yes and No in 'Sold as Vaccant' Field

--Select Distinct (Soldasvacant), Count(soldasvacant)
--from [Nashville Housing]
--group by soldasvacant
--order by 2


--select soldasvacant
--,   case when soldasvacant ='y' then 'yes'
--	when soldasvacant = 'n' then 'no'
--	else soldasvacant
--	end
--from [Nashville Housing]

--Update [Nashville Housing]
--set soldasvacant=case when soldasvacant ='y' then 'yes'
--	when soldasvacant = 'n' then 'no'
--	else soldasvacant
--	end

--Remove Duplicates

WITH RowNumCte AS(
Select *,
	Row_number () over (
	Partition by	ParcelID,
					PropertyAddress,
					SalePrice,
					SaleDate,
					legalreference
					Order by
					UniqueID) row_num
from [Nashville Housing] 
)
--delete
--from rownumcte
--where Row_Num>1
----order by PropertyAddress

select *
from rownumcte
where Row_Num>1
order by PropertyAddress


--Delete Unused Columns

Select *
from [Nashville Housing]


Alter Table [Nashville Housing]
Drop Column OwnerAddress,TaxDistrict, PropertyAddress