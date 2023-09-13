SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From Prashanth.dbo.NashvilleHousing

ALTER TABLE Prashanth.dbo.NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update Prashanth.dbo.NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE Prashanth.dbo.NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update Prashanth.dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select *
From Prashanth.dbo.NashvilleHousing

Select OwnerAddress
From Prashanth.dbo.NashvilleHousing

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From Prashanth.dbo.NashvilleHousing

ALTER TABLE Prashanth.dbo.NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update Prashanth.dbo.NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE Prashanth.dbo.NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update Prashanth.dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE Prashanth.dbo.NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update Prashanth.dbo.NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

Select *
From Prashanth.dbo.NashvilleHousing

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From Prashanth.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From Prashanth.dbo.NashvilleHousing

Update Prashanth.dbo.NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From Prashanth.dbo.NashvilleHousing
)
Select *
From RowNumCTE
Where row_num > 1

Select *
From Prashanth.dbo.NashvilleHousing

ALTER TABLE Prashanth.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
